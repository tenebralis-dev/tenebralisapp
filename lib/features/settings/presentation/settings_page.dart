import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/router.dart';
import '../../../app/strings.dart';
import '../../../app/locale_controller.dart';
import '../../auth/data/repositories/auth_repository.dart';

/// Settings Page (local-only).
///
/// Theme / language / font / wallpaper / notifications are stored locally.
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = ref.watch(stringsProvider);

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        // 统一由 theme_data_builder 管控 appBarTheme；这里不手写透明色。
        backgroundColor: null,
        title: Text(s.settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader(
            title: s.sectionApp,
            icon: Icons.tune,
          ),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: Icons.language,
            title: s.languageTitle,
            subtitle: _languageSubtitle(context),
            onTap: _showLanguageSheet,
          ),
          const SizedBox(height: 24),
          _SectionHeader(
            title: s.sectionAccount,
            icon: Icons.manage_accounts_outlined,
          ),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: Icons.logout,
            title: s.logoutTitle,
            subtitle: s.logoutSubtitle,
            onTap: _confirmAndLogout,
          ),
          const SizedBox(height: 24),
          _SectionHeader(title: s.sectionAbout, icon: Icons.info_outline),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: s.versionTitle,
            subtitle: 'v1.0.0',
            onTap: _openGithubRepo,
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: s.privacyTitle,
            subtitle: s.privacySubtitle,
            onTap: _showPrivacyPolicy,
          ),
          _SettingsTile(
            icon: Icons.mail_outline,
            title: s.contactDeveloperTitle,
            subtitle: 'kirenath@tuta.io',
            onTap: _contactDeveloper,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _languageSubtitle(BuildContext context) {
    final locale = ref.watch(localeControllerProvider) ?? const Locale('zh');
    return locale.languageCode.toLowerCase().startsWith('zh')
        ? '中文'
        : 'English';
  }

  void _showLanguageSheet() {
    final s = ref.read(stringsProvider);
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final locale = ref.watch(localeControllerProvider) ?? const Locale('zh');
        final isZh = locale.languageCode.toLowerCase().startsWith('zh');

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  s.languageTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                RadioListTile<bool>(
                  value: true,
                  groupValue: isZh,
                  title: const Text('中文'),
                  onChanged: (_) =>
                      ref.read(localeControllerProvider.notifier).setChinese(),
                ),
                RadioListTile<bool>(
                  value: false,
                  groupValue: isZh,
                  title: const Text('English'),
                  onChanged: (_) =>
                      ref.read(localeControllerProvider.notifier).setEnglish(),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(s.ok),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final s = ref.watch(stringsProvider);

        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    s.privacySheetTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    s.privacyIntro,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    s.privacySection1Title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.privacySection1Body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.privacySection2Title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.privacySection2Body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.privacySection3Title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.privacySection3Body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.privacySection4Title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.privacySection4Body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.privacySection5Title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.privacySection5Body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(s.privacyAcknowledge),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openGithubRepo() async {
    final uri = Uri.parse('https://github.com/tenebralis-dev/tenebralisapp');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('无法打开链接')),
      );
    }
  }

  Future<void> _contactDeveloper() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'kirenath@tuta.io',
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('无法打开邮箱应用')),
      );
    }
  }

  Future<void> _confirmAndLogout() async {
    final s = ref.read(stringsProvider);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s.logoutTitle),
          content: Text(s.logoutDialogContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(s.logoutConfirm),
            ),
          ],
        );
      },
    );

    if (confirm != true || !mounted) return;

    try {
      await ref.read(authRepositoryProvider).signOut();
      if (!mounted) return;
      context.go(AppRoutes.auth);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${s.logoutTitle}：$e')),
      );
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: scheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: scheme.primary,
              ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: scheme.onSurfaceVariant, size: 20),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              )
            : null,
        trailing:
            Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        onTap: onTap,
      ),
    );
  }
}
