import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';

/// Navigation helpers.
extension NavUtils on BuildContext {
  /// Pop if possible; otherwise go to OS home.
  void popOrGoHome() {
    if (canPop()) {
      pop();
      return;
    }

    go(AppRoutes.osHome);
  }
}
