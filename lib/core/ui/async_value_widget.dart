import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_empty_view.dart';
import 'app_error_view.dart';
import 'app_loading_view.dart';

/// A simple, app-wide standard renderer for Riverpod [AsyncValue].
///
/// Why this exists:
/// - Avoid repeating `async.when(loading/error/data)` boilerplate in every page.
/// - Ensure Loading/Empty/Error are visually consistent.
///
/// Usage:
/// ```dart
/// final async = ref.watch(myProvider);
/// return AsyncValueWidget(
///   value: async,
///   data: (data) => MyList(data: data),
///   empty: (data) => data.items.isEmpty, // optional
///   emptyTitle: '暂无数据',
/// );
/// ```
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loadingMessage,
    this.errorTitle = '加载失败',
    this.errorMessage = '请求失败，请稍后重试。',
    this.debugError,
    this.onRetry,
    this.onBack,
    this.empty,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon,
    this.emptyPrimaryAction,
  });

  final AsyncValue<T> value;

  /// Render data state.
  final Widget Function(T data) data;

  /// Optional custom loading message.
  final String? loadingMessage;

  /// Error view config.
  final String errorTitle;
  final String errorMessage;
  final String Function(Object error, StackTrace stackTrace)? debugError;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  /// Empty view config (optional).
  ///
  /// If [empty] is provided and returns true for the loaded data, an empty view
  /// is shown instead of calling [data].
  final bool Function(T data)? empty;
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData? emptyIcon;
  final Widget? emptyPrimaryAction;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => AppLoadingView(message: loadingMessage),
      error: (e, st) => AppErrorView(
        title: errorTitle,
        message: errorMessage,
        debugDetails: debugError?.call(e, st) ?? e.toString(),
        onRetry: onRetry,
        onBack: onBack,
      ),
      data: (d) {
        if (empty != null && empty!(d)) {
          return AppEmptyView(
            title: emptyTitle ?? '暂无数据',
            subtitle: emptySubtitle,
            icon: emptyIcon,
            primaryAction: emptyPrimaryAction,
          );
        }
        return data(d);
      },
    );
  }
}
