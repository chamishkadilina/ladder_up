// notification_settings_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsService {
  static const String _reminderTimeKey = 'daily_reminder_time';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  // Get the stored reminder time
  static Future<TimeOfDay?> getReminderTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString(_reminderTimeKey);

    if (timeString != null) {
      final parts = timeString.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
    return null;
  }

  // Save the reminder time
  static Future<void> setReminderTime(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _reminderTimeKey,
      '${time.hour}:${time.minute}',
    );
  }

  // Get notifications enabled status
  static Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  // Save notifications enabled status
  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);
  }
}
