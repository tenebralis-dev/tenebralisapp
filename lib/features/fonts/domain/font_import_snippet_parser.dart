/// Parser for user pasted snippets, e.g.
///
/// - @import("https://...")
/// - @import url('https://...');
/// - <style> ... @import url('https://...'); ...</style>
/// - direct https://...css / https://...ttf
///
/// Returns the first matched URL (we can enhance to multi-import later).
Uri? extractFirstImportUrl(String input) {
  final text = input.trim();
  if (text.isEmpty) return null;

  // Use triple-quoted raw strings to avoid escaping issues.

  // 1) @import("...") or @import('...')
  final importParen = RegExp(
    r'''@import\s*\(\s*(['\"])(https?:\/\/[^'\"]+)\1\s*\)''',
    caseSensitive: false,
    dotAll: true,
  );
  final m1 = importParen.firstMatch(text);
  if (m1 != null) {
    final url = m1.group(2);
    if (url != null) return Uri.tryParse(url);
  }

  // 2) @import url('...')
  final importUrl = RegExp(
    r'''@import\s+url\(\s*(['\"])(https?:\/\/[^'\"]+)\1\s*\)''',
    caseSensitive: false,
    dotAll: true,
  );
  final m2 = importUrl.firstMatch(text);
  if (m2 != null) {
    final url = m2.group(2);
    if (url != null) return Uri.tryParse(url);
  }

  // 3) Any first http(s) url
  final anyUrl = RegExp(
    r'''(https?:\/\/[^\s\"\']+)''',
    caseSensitive: false,
  );
  final m3 = anyUrl.firstMatch(text);
  if (m3 != null) {
    final url = m3.group(1);
    if (url != null) return Uri.tryParse(url);
  }

  return null;
}

bool isGoogleFontsCssUrl(Uri url) {
  return url.host.toLowerCase() == 'fonts.googleapis.com';
}

bool isProbablyCss(Uri url) {
  final p = url.path.toLowerCase();
  return p.endsWith('.css') || isGoogleFontsCssUrl(url);
}

bool isTtfOrOtfUrl(Uri url) {
  final p = url.path.toLowerCase();
  return p.endsWith('.ttf') || p.endsWith('.otf');
}
