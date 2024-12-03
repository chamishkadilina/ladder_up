import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ladder_up/models/setting.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsProvider extends ChangeNotifier {
  AppSettings _settings = AppSettings();

  AppSettings get settings => _settings;

  SettingsProvider() {
    loadSettings();
  }

  // Load settings from local storage
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('app_settings');

    if (settingsJson != null) {
      try {
        _settings = AppSettings.fromJson(json.decode(settingsJson));
        notifyListeners();
      } catch (e) {
        print('Error loading settings: $e');
        // Fallback to default settings
        _settings = AppSettings();
      }
    }
  }

  // Update and save language
  Future<void> setLanguage(String languageCode) async {
    _settings.language = languageCode;
    await _saveSettings();
    notifyListeners();
  }

  // Toggle notifications
  Future<void> toggleNotifications(bool value) async {
    _settings.notificationsEnabled = value;
    await _saveSettings();
    notifyListeners();
  }

  // Change theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _settings.themeMode = mode;
    await _saveSettings();
    notifyListeners();
  }

  // Save settings to local storage
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_settings', json.encode(_settings.toJson()));
  }

  Future<void> shareApp() async {
    await Share.share(
      'Check out Ladder Up app! Download it from [Your App Store Link]',
      subject: 'Ladder Up App',
    );
  }

  Future<void> rateApp() async {
    final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=your.package.name');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> openPrivacyPolicy() async {
    final Uri url = Uri.parse('https://your-privacy-policy-url.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
