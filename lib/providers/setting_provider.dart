import 'package:flutter/material.dart';
import 'package:ladder_up/models/setting.dart';
import 'package:ladder_up/services/wallpaper_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _isDarkModeKey = 'isDarkMode';

  Settings _settings = const Settings();
  Settings get settings => _settings;

  bool get isDarkMode => _settings.isDarkMode;
  String? get selectedWallpaper => _settings.selectedWallpaper;
  ThemeMode get themeMode =>
      _settings.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;
    final wallpaperPath = await WallpaperService.getSelectedWallpaper();

    _settings = Settings(
      isDarkMode: isDarkMode,
      selectedWallpaper: WallpaperService.isValidWallpaper(wallpaperPath)
          ? wallpaperPath
          : WallpaperService.defaultWallpaper,
    );
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _settings = _settings.copyWith(isDarkMode: !_settings.isDarkMode);
    await prefs.setBool(_isDarkModeKey, _settings.isDarkMode);
    notifyListeners();
  }

  Future<void> setWallpaper(String wallpaperPath) async {
    if (WallpaperService.isValidWallpaper(wallpaperPath)) {
      await WallpaperService.setSelectedWallpaper(wallpaperPath);
      _settings = _settings.copyWith(selectedWallpaper: wallpaperPath);
      notifyListeners();
    }
  }
}
