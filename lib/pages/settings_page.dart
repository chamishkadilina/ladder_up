import 'package:flutter/material.dart';
import 'package:ladder_up/services/notification_service.dart';
import 'package:ladder_up/services/notification_settings_service.dart';
import 'package:ladder_up/widgets/premium_tile.dart';
import 'package:provider/provider.dart';
import 'package:ladder_up/providers/project_provider.dart';

// Add this extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);
  bool _notificationsEnabled = true;
  bool _isLoading = true;
  String _selectedSound = 'default';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final savedTime = await NotificationSettingsService.getReminderTime();
    final notificationsEnabled =
        await NotificationSettingsService.getNotificationsEnabled();
    final savedSound = await NotificationSettingsService.getNotificationSound();

    setState(() {
      if (savedTime != null) {
        _reminderTime = savedTime;
      }
      _notificationsEnabled = notificationsEnabled;
      _selectedSound = savedSound;
      _isLoading = false;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });

    await NotificationSettingsService.setNotificationsEnabled(value);

    // Reschedule or cancel notifications based on new setting
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    if (value) {
      await projectProvider.scheduleTaskNotifications();
    } else {
      await NotificationService.cancelAllNotifications();
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(value ? 'Notifications enabled' : 'Notifications disabled'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );

    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });

      // Save the new time
      await NotificationSettingsService.setReminderTime(picked);

      // Reschedule notifications with new time
      if (_notificationsEnabled) {
        final projectProvider =
            Provider.of<ProjectProvider>(context, listen: false);
        await projectProvider.scheduleTaskNotifications();
      }

      // Show confirmation
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reminder time updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _selectNotificationSound() async {
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Notification Sound'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: NotificationSettingsService.notificationSounds.keys
                  .map((String sound) {
                return RadioListTile<String>(
                  title: Text(sound.capitalize()),
                  value: sound,
                  groupValue: _selectedSound,
                  activeColor: const Color(0xFF4B6CF5),
                  onChanged: (String? value) {
                    Navigator.pop(context, value);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF4B6CF5)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, _selectedSound),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Color(0xFF4B6CF5)),
              ),
            ),
          ],
        );
      },
    );

    if (result != null && result != _selectedSound) {
      setState(() {
        _selectedSound = result;
      });

      await NotificationSettingsService.setNotificationSound(result);

      // Reschedule notifications with new sound
      if (_notificationsEnabled) {
        final projectProvider =
            Provider.of<ProjectProvider>(context, listen: false);
        await projectProvider.scheduleTaskNotifications();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification sound updated'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Premium tile
                  const PremiumTile(),

                  // Notification Settings
                  _buildSettingsGroup(
                    'Notifications',
                    [
                      _buildSettingsTile(
                        icon: Icons.notifications_outlined,
                        title: 'Push Notifications',
                        subtitle: 'Enable or disable alerts',
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: _toggleNotifications,
                          activeColor: const Color(0xFF4B6CF5),
                        ),
                      ),
                      _buildSettingsTile(
                        icon: Icons.access_time,
                        title: 'Tasks Reminder At',
                        subtitle: 'Set time for daily reminders',
                        onTap: _notificationsEnabled ? _selectTime : null,
                        trailing: Text(
                          _reminderTime.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _notificationsEnabled
                                ? const Color(0xFF4B6CF5)
                                : Colors.grey,
                          ),
                        ),
                        disabled: !_notificationsEnabled,
                      ),
                      _buildSettingsTile(
                        icon: Icons.music_note_outlined,
                        title: 'Task Reminder Tone',
                        subtitle: _selectedSound.capitalize(),
                        onTap: _notificationsEnabled
                            ? _selectNotificationSound
                            : null,
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF4B6CF5),
                        ),
                        disabled: !_notificationsEnabled,
                      ),
                    ],
                  ),

                  // Preferences
                  _buildSettingsGroup(
                    'Preferences',
                    [
                      _buildSettingsTile(
                        icon: Icons.palette_outlined,
                        title: 'Appearance',
                        subtitle: 'Dark mode and theme settings',
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: 'English (US)',
                        onTap: () {},
                      ),
                    ],
                  ),

                  // About & Support
                  _buildSettingsGroup(
                    'About & Support',
                    [
                      _buildSettingsTile(
                        icon: Icons.share_outlined,
                        title: 'Share App',
                        subtitle: 'Invite friends to join',
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        icon: Icons.star_outline,
                        title: 'Rate Us',
                        subtitle: 'Share your feedback',
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'Read our privacy policy',
                        onTap: () {},
                      ),
                      _buildSettingsTile(
                        icon: Icons.info_outline,
                        title: 'App Version',
                        subtitle: 'Version 1.0.0',
                        trailing: const SizedBox.shrink(),
                      ),
                      _buildSettingsTile(
                        icon: Icons.logout_outlined,
                        title: 'Sign Out',
                        subtitle: 'Sign out from your account',
                        onTap: () {
                          // Add your sign out logic here
                        },
                        textColor: Colors
                            .red, // Add this parameter to your _buildSettingsTile
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> tiles) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),
          ...tiles,
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    void Function()? onTap,
    bool disabled = false,
    Color? textColor,
  }) {
    final Color defaultColor = disabled ? Colors.grey : const Color(0xFF1E1E1E);
    final Color titleColor = textColor ?? defaultColor;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey[200] : const Color(0xFFF0F3FE),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color:
              textColor ?? (disabled ? Colors.grey : const Color(0xFF4B6CF5)),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: disabled ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          (onTap != null
              ? const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF4B6CF5),
                )
              : null),
      onTap: disabled ? null : onTap,
    );
  }
}
