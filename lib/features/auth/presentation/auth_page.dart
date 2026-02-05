import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import 'widgets/auth_charm_background.dart';
import 'widgets/auth_system_card.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final s = ref.watch(stringsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: AuthCharmBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth < 420 ? 16.0 : 24.0;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s.authBrandTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s.authSubtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        s.authDescription,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      AuthSystemCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TabBar(
                              labelColor: scheme.onSurface,
                              unselectedLabelColor:
                                  scheme.onSurfaceVariant.withValues(alpha: 0.85),
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              tabs: [
                                Tab(text: s.tabLogin),
                                Tab(text: s.tabRegister),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 520,
                              child: TabBarView(
                                children: [
                                  LoginForm(),
                                  RegisterForm(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
