import 'package:flutter/material.dart';
import 'package:ladder_up/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _isDarkModeKey = 'isDarkMode';

  Settings _settings = const Settings();
  Settings get settings => _settings;

  bool get isDarkMode => _settings.isDarkMode;
  ThemeMode get themeMode =>
      _settings.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;

    _settings = Settings(isDarkMode: isDarkMode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = _settings.copyWith(isDarkMode: !_settings.isDarkMode);
    await prefs.setBool(_isDarkModeKey, _settings.isDarkMode);
    notifyListeners();
  }
}
