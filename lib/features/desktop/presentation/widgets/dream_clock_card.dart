import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/wallpaper_contrast_controller.dart';
import '../controllers/wallpaper_controller.dart';

/// 第一页顶部：时钟 + 日期 + 星期
class DreamClockCard extends ConsumerStatefulWidget {
  const DreamClockCard({super.key});

  @override
  ConsumerState<DreamClockCard> createState() => _DreamClockCardState();
}

class _DreamClockCardState extends ConsumerState<DreamClockCard> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    // 对齐到下一个分钟边界，减少不必要的刷新
    final secondsToNextMinute = 60 - _now.second;
    _timer = Timer(Duration(seconds: secondsToNextMinute), () {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(minutes: 1), (_) {
        if (!mounted) return;
        setState(() => _now = DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final hour = _now.hour.toString().padLeft(2, '0');
    final minute = _now.minute.toString().padLeft(2, '0');

    final dateText =
        '${_now.year}.${_now.month.toString().padLeft(2, '0')}.${_now.day.toString().padLeft(2, '0')}';
    final weekdayText = _weekdayText(context, _now.weekday);

    final hasWallpaper = ref.watch(wallpaperControllerProvider).isNone == false;
    final useLightFg = ref.watch(wallpaperLightForegroundProvider);

    // 有壁纸时：前景色统一跟 app icon label 一致（黑/白）。
    // 无壁纸时：保持原主题（onSurface / onSurfaceVariant）。
    final fgPrimary = hasWallpaper
        ? (useLightFg ? Colors.white : Colors.black)
        : scheme.onSurface;
    final fgSecondary = hasWallpaper
        ? (useLightFg
            ? Colors.white.withValues(alpha: 0.78)
            : Colors.black.withValues(alpha: 0.72))
        : scheme.onSurfaceVariant;

    // 有壁纸时：时钟卡片自身更“淡”（更透明），避免压暗背景。
    final cardBg = hasWallpaper
        ? scheme.surface.withValues(alpha: 0.28)
        : scheme.surface.withValues(alpha: 0.55);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 110),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$hour:$minute',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: fgPrimary,
                  ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dateText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: fgPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  weekdayText,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: fgSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 250.ms)
        .slideY(begin: -0.08, end: 0, curve: Curves.easeOut);
  }

  String _weekdayText(BuildContext context, int weekday) {
    final locale = Localizations.localeOf(context);
    final isZh = locale.languageCode.toLowerCase().startsWith('zh');

    if (isZh) {
      switch (weekday) {
        case DateTime.monday:
          return '星期一';
        case DateTime.tuesday:
          return '星期二';
        case DateTime.wednesday:
          return '星期三';
        case DateTime.thursday:
          return '星期四';
        case DateTime.friday:
          return '星期五';
        case DateTime.saturday:
          return '星期六';
        case DateTime.sunday:
          return '星期日';
        default:
          return '';
      }
    }

    // English
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
