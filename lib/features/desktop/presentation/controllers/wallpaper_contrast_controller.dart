import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

import '../../data/wallpaper_prefs.dart';
import 'wallpaper_controller.dart';

/// Whether foreground content on top of wallpaper should be light or dark.
///
/// For now we expose a simple bool: `true` means use light (white) foreground.
///
/// Note: current logic samples a downscaled image and estimates luminance.
/// For remote images, we default to `true` (light foreground) to avoid
/// extra dependencies/network bytes.
class WallpaperContrastController extends StateNotifier<bool> {
  WallpaperContrastController() : super(true);

  Future<void> setLightForeground() async => state = true;
  Future<void> setDarkForeground() async => state = false;

  Future<void> computeFromWallpaper(String path) async {
    // default
    state = true;

    final uri = Uri.tryParse(path);
    final isRemote = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    if (isRemote) {
      // TODO: optionally download bytes and analyze.
      state = true;
      return;
    }

    final file = File(path);
    if (!file.existsSync()) {
      state = true;
      return;
    }

    try {
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: 64,
        targetHeight: 64,
      );
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (data == null) {
        state = true;
        return;
      }

      final l = _estimateLuminance(data);
      // threshold: < 0.5 means dark wallpaper => use light foreground.
      state = l < 0.5;
    } catch (_) {
      state = true;
    }
  }

  double _estimateLuminance(ByteData rgba) {
    // rgba length is width*height*4
    final length = rgba.lengthInBytes;
    if (length < 4) return 0.0;

    // sample every N pixels
    const step = 16 * 4; // 16 pixels
    double sum = 0;
    int count = 0;

    for (int i = 0; i < length; i += step) {
      final r = rgba.getUint8(i);
      final g = rgba.getUint8(i + 1);
      final b = rgba.getUint8(i + 2);
      // relative luminance (sRGB approx)
      final lum = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255.0;
      sum += lum;
      count++;
    }

    return count == 0 ? 0.0 : (sum / count);
  }
}

final wallpaperLightForegroundProvider =
    StateNotifierProvider<WallpaperContrastController, bool>((ref) {
  final controller = WallpaperContrastController();

  // recompute when wallpaper changes
  ref.listen<WallpaperConfig>(wallpaperControllerProvider, (prev, next) {
    if (next.isNone) {
      controller.state = true;
      return;
    }
    // fire and forget
    unawaited(controller.computeFromWallpaper(next.value));
  });

  return controller;
});
