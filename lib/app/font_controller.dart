import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global font family controller.
///
/// Stores a Material `fontFamily` value used by ThemeData.
/// Note: uses SharedPreferences persistence.
class FontController extends StateNotifier<String> {
  FontController({required String initial}) : super(initial);

  static const _prefsKey = 'settings.fontFamily';

  static Future<String> loadInitial() async {
    // ignore: avoid_redundant_argument_values
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsKey) ?? AppFontFamily.noto;
  }

  Future<void> setFont(String fontFamily) async {
    state = fontFamily;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, fontFamily);
  }

  Future<void> setChillRoundM() => setFont(AppFontFamily.chillRoundM);
  Future<void> setMaruko() => setFont(AppFontFamily.maruko);
  Future<void> setNoto() => setFont(AppFontFamily.noto);

  Future<void> setEarlySummerSerif() => setFont(AppFontFamily.earlySummerSerif);
  Future<void> setMaShanZheng() => setFont(AppFontFamily.mashanzheng);
  Future<void> setMoonStarsKai() => setFont(AppFontFamily.moonStarsKai);
  Future<void> setWenYuanSans() => setFont(AppFontFamily.wenYuanSans);
  Future<void> setXCDUANZHUANGSONGTI() => setFont(AppFontFamily.xcduanzhuangsongti);
  Future<void> setYShiWritten() => setFont(AppFontFamily.yshiWritten);
}

/// Centralized font family names (must match pubspec.yaml).
abstract class AppFontFamily {
  static const chillRoundM = 'ChillRoundM';
  static const maruko = 'Maruko';
  static const noto = 'NotoSansSC';

  static const earlySummerSerif = 'EarlySummerSerif';
  static const mashanzheng = 'mashanzheng';
  static const moonStarsKai = 'MoonStarsKai';
  static const wenYuanSans = 'WenYuanSans';
  static const xcduanzhuangsongti = 'XCDUANZHUANGSONGTI';
  static const yshiWritten = 'YShi-Written';

  static const all = <String>[
    chillRoundM,
    maruko,
    noto,
    earlySummerSerif,
    mashanzheng,
    moonStarsKai,
    wenYuanSans,
    xcduanzhuangsongti,
    yshiWritten,
  ];
}

/// Bootstrap provider: loads initial font from SharedPreferences.
final fontControllerBootstrapProvider = FutureProvider<String>((ref) async {
  return FontController.loadInitial();
});

final fontControllerProvider =
    StateNotifierProvider<FontController, String>((ref) {
  // 从 SharedPreferences 异步加载初始字体，然后在首次完成后写入 state。
  final controller = FontController(initial: AppFontFamily.noto);
  Future<void>(() async {
    final initial = await FontController.loadInitial();
    if (initial != controller.state) {
      controller.state = initial;
    }
  });
  return controller;
});

/// Human-readable labels shown in Settings.
String fontDisplayName(String fontFamily, {required bool isZh}) {
  switch (fontFamily) {
    case AppFontFamily.chillRoundM:
      return isZh ? '寒蝉半圆体（ChillRoundM）' : 'ChillRoundM';
    case AppFontFamily.maruko:
      return isZh ? '马路口圆体（Maruko）' : 'Maruko';
    case AppFontFamily.noto:
      return isZh ? 'Noto' : 'Noto';
    case AppFontFamily.earlySummerSerif:
      return isZh ? '初夏明朝体（EarlySummerSerif）' : 'EarlySummerSerif';
    case AppFontFamily.mashanzheng:
      return isZh ? '马善政楷书（mashanzheng）' : 'mashanzheng';
    case AppFontFamily.moonStarsKai:
      return isZh ? '月星楷（MoonStarsKai）' : 'MoonStarsKai';
    case AppFontFamily.wenYuanSans:
      return isZh ? '文源黑体（WenYuanSans）' : 'WenYuanSans';
    case AppFontFamily.xcduanzhuangsongti:
      return isZh ? '香萃端庄宋体（XCDUANZHUANGSONGTI）' : 'XCDUANZHUANGSONGTI';
    case AppFontFamily.yshiWritten:
      return isZh ? '写意体（YShi-Written）' : 'YShi-Written';
    default:
      return fontFamily;
  }
}
