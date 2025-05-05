import 'package:flutter/material.dart';

enum AppTheme { roseBud, sandwisp }
enum AppLanguage { english, filipino }

class AppState extends ChangeNotifier {
  AppTheme _theme = AppTheme.roseBud;
  AppLanguage _language = AppLanguage.english;

  AppTheme get theme => _theme;
  AppLanguage get language => _language;

  void updatePreferences({
    required AppTheme theme,
    required AppLanguage language,
  }) {
    _theme = theme;
    _language = language;
    notifyListeners();
  }
}

ThemeData getThemeData(AppTheme theme) {
  switch (theme) {
    case AppTheme.sandwisp:
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFF1B5), // Sandwisp
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEED97B), // Deeper sand shade
          foregroundColor: Colors.black87,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFEED97B),
          secondary: Color(0xFFBCA45D),
        ),
      );

    case AppTheme.roseBud:
    default:
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFABAB), // Rose Bud
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF7F7F), // Deeper rose
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF7F7F),
          secondary: Color(0xFFDB6E6E),
        ),
      );
  }
}
