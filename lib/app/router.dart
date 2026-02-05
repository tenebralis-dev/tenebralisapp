import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/boot/presentation/boot_page.dart';
import '../features/desktop/presentation/dream_os_page.dart';
import '../features/auth/presentation/auth_page.dart';
import '../features/connection/presentation/connections_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/profiles/presentation/profile_page.dart';
import '../features/home/presentation/home_hud_page.dart';
import '../features/desktop/icon_customization/presentation/icon_customize_page.dart';
import '../features/theme/presentation/theme_customization_page.dart';
import '../features/customize/presentation/customize_hub_page.dart';

/// Centralized route path constants.
///
/// NOTE: keep these in sync with GoRouter config.
abstract class AppRoutes {
  static const boot = '/';
  static const auth = '/auth';
  static const osHome = '/os/home';
  static const os = osHome; // Backwards-compat for existing calls.

  static const osConnection = '/os/connection';
  static const osSettings = '/os/apps/settings';
  static const osCustomize = '/os/apps/customize';
  static const osThemeCustomize = '/os/apps/theme_custom';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.auth,
    routes: [
      GoRoute(
        path: AppRoutes.boot,
        builder: (context, state) => const BootPage(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.osHome,
        builder: (context, state) => const DreamOSPage(),
      ),
      GoRoute(
        path: AppRoutes.osConnection,
        builder: (context, state) => const ConnectionsPage(),
      ),
      GoRoute(
        path: AppRoutes.osSettings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.osCustomize,
        builder: (context, state) => const CustomizeHubPage(),
      ),
      GoRoute(
        path: AppRoutes.osThemeCustomize,
        builder: (context, state) => const ThemeCustomizationPage(),
      ),
      // App routes
      GoRoute(
        path: '/os/apps/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/os/apps/identity',
        builder: (context, state) => const HomeHudPage(),
      ),
      // Minimal app routes (placeholder pages) so tapping icons works.
      GoRoute(
        path: '/os/apps/:appId',
        builder: (context, state) {
          final appId = state.pathParameters['appId'] ?? 'app';
          return _AppPlaceholderPage(appId: appId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GoException: no routes for location: ${state.uri.path}',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go(AppRoutes.osHome),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

class _AppPlaceholderPage extends StatelessWidget {
  const _AppPlaceholderPage({required this.appId});

  final String appId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(appId),
      ),
      body: const Center(
        child: Text(
          'Coming soon...',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
