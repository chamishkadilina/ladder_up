import 'package:flutter/material.dart';
import 'package:ladder_up/providers/auth_provider.dart';
import 'package:ladder_up/providers/setting_provider.dart';
import 'package:ladder_up/widgets/premium_tile.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Load settings when page initializes
    Provider.of<SettingsProvider>(context, listen: false).loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Use context to access the AuthProvider
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFF754BE5),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: authProvider.user?.photoURL != null
                      ? NetworkImage(authProvider.user!.photoURL!)
                      : null,
                  backgroundColor: Colors.grey.shade200,
                  child: authProvider.user?.photoURL == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  authProvider.user?.displayName ?? 'User',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  authProvider.user?.email ?? 'user@example.com',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Upgrade to premium
                const PremiumTile(),
                const SizedBox(height: 24),

                // Preferences
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Preferences',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // list of settings
                Expanded(
                  child: ListView(
                    children: [
                      // Notification Setting
                      SwitchListTile(
                        title: const Text('Notifications'),
                        value: settingsProvider.settings.notificationsEnabled,
                        onChanged: (bool value) {
                          settingsProvider.toggleNotifications(value);
                        },
                      ),

                      // Language Setting
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        subtitle: Text(settingsProvider.settings.language),
                        onTap: () => _showLanguageDialog(context),
                      ),

                      // Theme Setting
                      ListTile(
                        leading: const Icon(Icons.color_lens_outlined),
                        title: const Text('Theme'),
                        subtitle: Text(
                          _getThemeModeName(
                              settingsProvider.settings.themeMode),
                        ),
                        onTap: () => _showThemeDialog(context),
                      ),

                      // Rate App
                      ListTile(
                        leading: const Icon(Icons.star_border),
                        title: const Text('Rate Us'),
                        onTap: () => settingsProvider.rateApp(),
                      ),

                      // Privacy Policy
                      ListTile(
                        leading: const Icon(Icons.shield_outlined),
                        title: const Text('Privacy Policy'),
                        onTap: () => settingsProvider.openPrivacyPolicy(),
                      ),

                      // Share App
                      ListTile(
                        leading: const Icon(Icons.share_outlined),
                        title: const Text('Share with Friends'),
                        onTap: () => settingsProvider.shareApp(),
                      ),
                    ],
                  ),
                ),

                // App version
                const Text(
                  'App version: 1.0.0',
                  style: TextStyle(
                    color: Color(0xFF754BE5),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper method to show language selection dialog
  void _showLanguageDialog(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  settingsProvider.setLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Spanish'),
                onTap: () {
                  settingsProvider.setLanguage('es');
                  Navigator.pop(context);
                },
              ),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }

  // Helper method to show theme selection dialog
  void _showThemeDialog(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Light'),
                onTap: () {
                  settingsProvider.setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark'),
                onTap: () {
                  settingsProvider.setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('System'),
                onTap: () {
                  settingsProvider.setThemeMode(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to get theme mode name
  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
