import 'package:flutter/material.dart';

enum AppTheme { dark, light }
enum AppLanguage { english, filipino }

class AppState extends ChangeNotifier {
  AppTheme _theme = AppTheme.light;
  AppLanguage _language = AppLanguage.english;

  AppTheme get theme => _theme;
  AppLanguage get language => _language;

  void updatePreferences({required AppTheme theme, required AppLanguage language}) {
    _theme = theme;
    _language = language;
    notifyListeners();
  }
}

ThemeData getThemeData(AppTheme theme) {
  switch (theme) {
    case AppTheme.dark:
      return ThemeData.dark();
    case AppTheme.light:
    default:
      return ThemeData.light();
  }
}