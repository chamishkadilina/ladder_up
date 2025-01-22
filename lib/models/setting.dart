class Settings {
  final bool isDarkMode;

  const Settings({
    this.isDarkMode = false,
  });

  Settings copyWith({
    bool? isDarkMode,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isDarkMode: json['isDarkMode'] ?? false,
    );
  }
}
