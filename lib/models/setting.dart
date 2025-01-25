class Settings {
  final bool isDarkMode;
  final String? selectedWallpaper;

  const Settings({
    this.isDarkMode = false,
    this.selectedWallpaper,
  });

  Settings copyWith({
    bool? isDarkMode,
    String? selectedWallpaper,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectedWallpaper: selectedWallpaper ?? this.selectedWallpaper,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'selectedWallpaper': selectedWallpaper,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isDarkMode: json['isDarkMode'] ?? false,
      selectedWallpaper: json['selectedWallpaper'],
    );
  }
}
