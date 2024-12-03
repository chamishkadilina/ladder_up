import 'package:flutter/material.dart';

class AppSettings {
  String language;
  bool notificationsEnabled;
  ThemeMode themeMode;

  AppSettings({
    this.language = 'en', // default language
    this.notificationsEnabled = true,
    this.themeMode = ThemeMode.system,
  });

  // Add method to convert to and from JSON for local storage
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      language: json['language'] ?? 'en',
      notificationsEnabled: json['notifications'] ?? true,
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.toString() == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'notifications': notificationsEnabled,
      'themeMode': themeMode.toString(),
    };
  }
}
