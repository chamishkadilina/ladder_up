import 'package:shared_preferences/shared_preferences.dart';

class WallpaperService {
  static const String wallpaperKey = 'selected_wallpaper';

  // List of available wallpapers
  static final List<String> availableWallpapers = [
    'assets/wallpapers/wallpaper1.jpg',
    'assets/wallpapers/wallpaper2.jpg',
    'assets/wallpapers/wallpaper3.jpg',
    'assets/wallpapers/wallpaper4.jpg',
    'assets/wallpapers/wallpaper5.jpg',
    'assets/wallpapers/wallpaper6.jpg',
    'assets/wallpapers/wallpaper7.jpg',
    'assets/wallpapers/wallpaper8.jpg',
    'assets/wallpapers/wallpaper9.jpg',
    'assets/wallpapers/wallpaper10.jpg',
    'assets/wallpapers/wallpaper11.jpg',
    'assets/wallpapers/wallpaper12.jpg',
  ];

  // Get the currently selected wallpaper
  static Future<String?> getSelectedWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(wallpaperKey);
  }

  // Save selected wallpaper
  static Future<void> setSelectedWallpaper(String wallpaperPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(wallpaperKey, wallpaperPath);
  }

  // Check if a wallpaper is valid
  static bool isValidWallpaper(String? wallpaperPath) {
    return wallpaperPath != null && availableWallpapers.contains(wallpaperPath);
  }

  // Get default wallpaper (first in the list)
  static String get defaultWallpaper => availableWallpapers.first;
}
