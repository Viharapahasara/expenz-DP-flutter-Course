import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeService extends ChangeNotifier {
  AppThemeService._();

  static final AppThemeService instance = AppThemeService._();
  static const String _preferenceKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();
    final String? savedMode = preferences.getString(_preferenceKey);
    _themeMode = ThemeMode.values.firstWhere(
      (ThemeMode mode) => mode.name == savedMode,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final SharedPreferences preferences =
        await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, mode.name);
  }
}