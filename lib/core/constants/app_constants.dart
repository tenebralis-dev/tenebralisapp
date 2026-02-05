/// App Constants for Tenebralis Dream System
library;

/// Supabase configuration
/// TODO: Replace with actual Supabase credentials
abstract class SupabaseConstants {
  static const String url = 'YOUR_SUPABASE_URL';
  static const String anonKey = 'YOUR_SUPABASE_ANON_KEY';
}

/// App metadata
abstract class AppConstants {
  static const String appName = 'Tenebralis Dream System';
  static const String appNameCN = '界影浮光';
  static const String version = '1.0.0';
}

/// Dock app identifiers
abstract class DockApps {
  static const List<String> items = ['dream', 'chat', 'quest', 'profile'];
}

/// App Grid pages configuration
abstract class AppGridConfig {
  static const List<List<String>> pages = [
    // Page 1
    ['affection', 'identity', 'worlds', 'forum', 'shop', 'achievement'],
    // Page 2
    ['memo', 'ledger', 'gallery', 'calendar', 'pomodoro', 'music'],
    // Page 3
    ['settings'],
  ];
}

/// Chronicle types
abstract class ChronicleTypes {
  static const String chat = 'chat';
  static const String memo = 'memo';
  static const String transaction = 'transaction';
}

/// Relationship target types
abstract class RelationshipTargetTypes {
  static const String npc = 'npc';
  static const String quest = 'quest';
}
