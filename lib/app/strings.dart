import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locale_controller.dart';

/// Lightweight string localization (no ARB yet).
///
/// Use: `final s = ref.watch(stringsProvider);` then `s.settingsTitle`.
class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  bool get isZh => locale.languageCode.toLowerCase().startsWith('zh');

  // --- Common ---
  String get ok => isZh ? '确定' : 'OK';
  String get cancel => isZh ? '取消' : 'Cancel';

  // --- Auth ---
  String get authBrandTitle => isZh ? '界影浮光' : 'Tenebralis';
  String get authSubtitle => 'Tenebralis Dream System';
  String get authDescription => isZh
      ? '系统将通过邮箱完成身份确认'
      : 'Identity will be verified via email.';

  String get tabLogin => isZh ? '登录' : 'Sign in';
  String get tabRegister => isZh ? '注册' : 'Sign up';

  String get emailLabel => isZh ? '邮箱' : 'Email';
  String get emailPlaceholder => 'example@example.com';

  String get passwordLabel => isZh ? '密码' : 'Password';
  String get passwordPlaceholder => isZh ? '输入密码' : 'Enter password';

  String get otpLabel => isZh ? '验证码' : 'Verification code';
  String get otpPlaceholder => isZh ? '输入 6 位验证码' : 'Enter the 6-digit code';

  String get enterSystem => isZh ? '进入系统' : 'Enter';
  String get continueHint => isZh ? '输入邮箱与密码以继续。' : 'Enter your email and password to continue.';
  String get rememberMe => isZh ? '记住我' : 'Remember me';

  String get showPassword => isZh ? '显示密码' : 'Show password';
  String get hidePassword => isZh ? '隐藏密码' : 'Hide password';

  String get createAccount => isZh ? '创建账号' : 'Create account';
  String get loginAccountTitle => isZh ? '登录账号' : 'Sign in';
  String get emailVerifyTitle => isZh ? '邮箱验证' : 'Email verification';

  String get confirmPasswordLabel => isZh ? '确认密码' : 'Confirm password';
  String get confirmPasswordPlaceholder =>
      isZh ? '再次输入密码' : 'Re-enter password';

  String get registerAndSendOtp =>
      isZh ? '注册并发送验证码' : 'Sign up & send code';
  String get verifyAndEnter => isZh ? '验证并进入' : 'Verify & enter';

  String get backToEditEmailPassword =>
      isZh ? '返回修改邮箱/密码' : 'Back to edit email/password';

  String get otpSentHint => isZh
      ? '已向你的邮箱发送 6 位验证码，请输入后完成验证。'
      : 'A 6-digit code has been sent to your email. Enter it to verify.';

  // --- Validation ---
  String get enterEmailError => isZh ? '请输入邮箱' : 'Please enter your email.';
  String get invalidEmailError => isZh ? '邮箱格式不正确' : 'Invalid email format.';
  String get enterPasswordError => isZh ? '请输入密码' : 'Please enter your password.';
  String get passwordMinError => isZh ? '密码至少 6 位' : 'Password must be at least 6 characters.';
  String get enterOtpError => isZh ? '请输入验证码' : 'Please enter the code.';
  String get otpLengthError => isZh ? '验证码长度不正确' : 'Invalid code length.';
  String get confirmPasswordError => isZh ? '请再次输入密码' : 'Please confirm your password.';
  String get passwordNotMatchError => isZh ? '两次密码不一致' : 'Passwords do not match.';

  // --- Desktop / Apps ---
  String get appSearchHint => isZh ? '搜索应用...' : 'Search apps...';
  String get appAffection => isZh ? '好感' : 'Affection';
  String get appIdentity => isZh ? '身份' : 'Identity';
  String get appWorlds => isZh ? '世界' : 'Worlds';
  String get appForum => isZh ? '论坛' : 'Forum';
  String get appShop => isZh ? '商店' : 'Shop';
  String get appAchievement => isZh ? '成就' : 'Achievement';
  String get appMemo => isZh ? '备忘' : 'Memo';
  String get appLedger => isZh ? '账本' : 'Ledger';
  String get appGallery => isZh ? '相册' : 'Gallery';
  String get appCalendar => isZh ? '日历' : 'Calendar';
  String get appPomodoro => isZh ? '番茄钟' : 'Pomodoro';
  String get appMusic => isZh ? '音乐' : 'Music';
  String get appConnection => isZh ? '连接' : 'Connection';
  String get appSettings => isZh ? '设置' : 'Settings';
  String get appCustomize => isZh ? '自定义' : 'Customize';

  // Dock
  String get dockDream => isZh ? '梦境' : 'Dream';
  String get dockChat => isZh ? '对话' : 'Chat';
  String get dockQuest => isZh ? '任务' : 'Quests';
  String get dockProfile => isZh ? '档案' : 'Profile';

  // --- Settings ---
  String get settingsTitle => isZh ? '设置' : 'Settings';
  String get sectionApp => isZh ? '应用设置' : 'App';
  String get sectionAccount => isZh ? '账户' : 'Account';
  String get sectionAbout => isZh ? '关于' : 'About';

  String get themeTitle => isZh ? '主题' : 'Theme';
  String get themeSubtitle =>
      isZh ? '选择默认浅色/默认深色，或其它配色方案' : 'Choose default light/dark or other palettes.';

  String get themeSheetTitle => isZh ? '主题与配色' : 'Theme & palette';
  String get themeModeSystem => isZh ? '跟随系统' : 'System';

  String get themeDefaultLight => isZh ? '默认浅色' : 'Default Light';
  String get themeDefaultDark => isZh ? '默认深色' : 'Default Dark';
  String get themeGroupLight => isZh ? '浅色方案' : 'Light palettes';
  String get themeGroupDark => isZh ? '深色方案' : 'Dark palettes';
  String get colorSchemeRosa => isZh ? '玫粉' : 'Rosa';
  String get colorSchemeSlate => isZh ? '石板' : 'Slate';
  String get colorSchemeMint => isZh ? '薄荷' : 'Mint';
  String get colorSchemeLavender => isZh ? '薰衣草' : 'Lavender';
  String get colorSchemeKraftDark => isZh ? '牛皮纸' : 'Kraft';

  String get fontTitle => isZh ? '字体' : 'Font';
  String get fontSubtitle => isZh ? '选择全局字体' : 'Choose a global font';
  String get fontCurrent => isZh ? '当前字体' : 'Current font';
  String get fontHint => isZh ? '提示：部分组件可能因字体不完整而回退到系统字体。' : 'Note: some glyphs may fall back to system fonts.';
  String get fontApply => isZh ? '应用' : 'Apply';

  String get languageTitle => isZh ? '语言' : 'Language';
  String get languageSubtitle => isZh ? '中文 / English' : 'Chinese / English';

  String get wallpaperTitle => isZh ? '壁纸' : 'Wallpaper';
  String get wallpaperSubtitle =>
      isZh ? '自定义主界面壁纸（直链或本地）' : 'Customize home wallpaper (URL or local).';

  String get notificationsTitle => isZh ? '通知' : 'Notifications';
  String get notificationsSubtitle => isZh ? '通知偏好' : 'Preferences';

  String get logoutTitle => isZh ? '退出登录' : 'Sign out';
  String get logoutSubtitle => isZh ? '结束当前会话' : 'End current session';

  String get logoutDialogContent => isZh
      ? '将结束当前会话，并返回认证界面。'
      : 'This will end the current session and return to the auth screen.';
  String get logoutConfirm => isZh ? '退出' : 'Sign out';

  String get versionTitle => isZh ? '版本' : 'Version';

  String get privacyTitle => isZh ? '隐私政策' : 'Privacy policy';
  String get contactDeveloperTitle => isZh ? '联系开发者' : 'Contact developer';
  String get privacySubtitle =>
      isZh ? '数据收集与使用说明' : 'Data collection and usage';

  // Wallpaper sheet
  String get wallpaperUrlLabel => isZh ? '图片直链（jpg/png）' : 'Image URL (jpg/png)';
  String get wallpaperUrlHint => isZh ? 'https://.../wallpaper.jpg' : 'https://.../wallpaper.jpg';
  String get wallpaperApplyUrl => isZh ? '应用直链壁纸' : 'Apply URL wallpaper';
  String get wallpaperPickLocal => isZh ? '选择本地图片' : 'Pick local image';
  String get wallpaperPickFailed => isZh ? '选择失败' : 'Pick failed';
  String get wallpaperClear => isZh ? '清除壁纸' : 'Clear';
  String get wallpaperUrlEmpty => isZh ? '请输入壁纸图片直链' : 'Please enter an image URL.';
  String get wallpaperUrlInvalid =>
      isZh ? '链接需为 http/https 且以 .jpg/.png 结尾' : 'URL must be http/https and end with .jpg/.png.';
  String get wallpaperLocalNotFound => isZh ? '本地文件不存在' : 'Local file not found.';
  String wallpaperCurrent(Object current) =>
      isZh ? '当前：$current' : 'Current: $current';

  // Notifications sheet
  String get notificationsSheetTitle => isZh ? '通知' : 'Notifications';
  String get notificationsAllow => isZh ? '允许通知' : 'Allow notifications';
  String get notificationsSystem => isZh ? '系统通知' : 'System alerts';
  String get notificationsSystemDesc =>
      isZh ? '身份状态、同步与安全提醒' : 'Auth status, sync, and security alerts';
  String get notificationsUpdates => isZh ? '更新通知' : 'Updates';
  String get notificationsUpdatesDesc =>
      isZh ? '版本更新与新功能提示' : 'Version updates and new features';
  String get notificationsHint => isZh
      ? '提示：通知偏好将于后续版本与系统通知权限联动。'
      : 'Note: preferences will be linked to system permissions in a future update.';

  // Privacy sheet
  String get privacySheetTitle => isZh ? '隐私政策' : 'Privacy Policy';

  String get privacyIntro => isZh
      ? '最近更新：2026年2月\n\n欢迎来到 Tenebralis Dream System（以下简称“本应用”）。我们尊重您的隐私，并致力于保护您的个人数据。本应用旨在成为一个个人 AI 驱动的操作系统，透明度是我们的核心价值观。'
      : 'Last Updated: February, 2026\n\nWelcome to the Tenebralis Dream System (the "App"). We respect your privacy and are committed to protecting your personal data. This application is designed as a personal AI-driven operating system, and transparency is our core value.';

  String get privacySection1Title => isZh ? '1. 我们收集的信息' : '1. Information We Collect';
  String get privacySection1Body => isZh
      ? '我们严格将数据收集限制在应用功能所需的范围内：\n\n• 账户信息：\n  - 邮箱地址：用于唯一用户标识和登录。\n  - 密码：严格以加密（哈希）格式存储。我们无法查看或解密您的密码。\n\n• 用户内容：\n  - 聊天数据与世界设定：您与 AI NPC 的对话记录、世界配置以及生成的设定将存储在数据库中，以提供持久化记忆功能（上下文总结）。\n\n• 我们不收集的信息：\n  - AI API Key：我们绝不在服务器上存储您的个人 API Key（例如 OpenAI、Claude、绘图 API、语音生成 API等）。即使您输入了 Key，它们也仅保存在您的本地设备上或仅用于传输，绝不会保存于我们的后端。'
      : 'We strictly limit data collection to what is necessary for the App\'s functionality:\n\n• Account Information:\n  - Email Address: Used for unique user identification and login.\n  - Password: Stored strictly in encrypted (hashed) format. We cannot see or decrypt your password.\n\n• User Content:\n  - Chat Data & World Settings: Your dialogue history with AI NPCs, world configurations, and generated lore are stored in the database to provide persistent memory features (context summary).\n\n• What We Do NOT Collect:\n  - AI API Keys: We NEVER store your personal API Keys (e.g., OpenAI, Claude, image generation APIs, voice generation APIs) on our servers. If input, these keys are either stored locally on your device or used strictly for direct transmission and are not saved in our backend.';

  String get privacySection2Title => isZh ? '2. 我们如何使用您的数据' : '2. How We Use Your Data';
  String get privacySection2Body => isZh
      ? '• 用于提供、维护和改进“梦境系统”的体验。\n• 用于在不同设备（如手机端和 Web 端）之间同步您的进度。'
      : '• To provide, maintain, and improve the "Dream OS" experience.\n• To synchronize your progress across different devices (e.g., between Mobile App and Web).';

  String get privacySection3Title => isZh ? '3. 数据共享与披露' : '3. Data Sharing & Disclosure';
  String get privacySection3Body => isZh
      ? '• 绝不售卖：我们不会向他人出售、交易或出租您的个人身份信息。即使未来本应用商业化，您的数据依然属于您。\n\n• 第三方服务：\n  - Supabase：我们使用 Supabase 进行身份验证和数据存储。底层基础设施的安全性请参考 Supabase 的隐私政策。'
      : '• No Selling: We do not sell, trade, or rent your personal identification information to others. Even if we monetize the App in the future, your data remains yours.\n\n• Third-Party Service:\n  - Supabase: We use Supabase (BaaS) for authentication and data storage. Please refer to Supabase\'s privacy policy for underlying infrastructure security.';

  String get privacySection4Title => isZh ? '4. 用户控制与自托管' : '4. User Control & Self-Hosting';
  String get privacySection4Body => isZh
      ? '• 自建 Supabase 实例：本应用支持连接到您自建的 Supabase 实例。您可以在发行页面下载开源版本，并将自己的数据库链接与密钥打包进应用，从而确保对数据的 100% 控制权。'
      : '• Self-hosted Supabase: The App supports connecting to your self-hosted Supabase instance. You can download the open-source build from the release page and package your own database URL and keys into the App, ensuring 100% control over your data.';

  String get privacySection5Title => isZh ? '5. 联系我们' : '5. Contact Us';
  String get privacySection5Body => isZh
      ? '如果您对本隐私政策有任何疑问，请通过官方支持渠道联系开发者。'
      : 'If you have any questions about this Privacy Policy, please contact the developer via the official support channel.';

  String get privacyAcknowledge => isZh ? '我已了解' : 'Got it';
}

final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeControllerProvider) ?? const Locale('zh');
  return AppStrings(locale);
});
