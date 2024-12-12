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
    Provider.of<SettingsProvider>(context, listen: false).loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 145, 145, 145),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User Name container
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue.shade100.withOpacity(0.5),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade100.withOpacity(0.3),
                                  blurRadius: 15,
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: authProvider.user?.photoURL !=
                                      null
                                  ? NetworkImage(authProvider.user!.photoURL!)
                                  : null,
                              backgroundColor: Colors.white.withOpacity(0.4),
                              child: authProvider.user?.photoURL == null
                                  ? Icon(Icons.person,
                                      size: 50, color: Colors.blue.shade300)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authProvider.user?.displayName ?? 'User',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue.shade900,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              authProvider.user?.email ?? 'user@example.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Premium Upgrade Tile
                const PremiumTile(),
                const SizedBox(height: 16),

                // Settings Sections with Modern Card Design
                _buildSettingsSection(
                  context,
                  title: 'Account Preferences',
                  children: [
                    _buildSettingsTile(
                      context,
                      icon: Icons.account_circle,
                      titleWidget: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Account',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Free User',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF754BE5),
                            ),
                          ),
                        ],
                      ),
                      onTap: null, // Go to Upgrade plane page
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      trailing: Switch(
                        value: settingsProvider.settings.notificationsEnabled,
                        onChanged: (bool value) {
                          settingsProvider.toggleNotifications(value);
                        },
                        activeColor: const Color(0xFF009DFF),
                      ),
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.language,
                      titleWidget: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Language',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'en',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF754BE5),
                            ),
                          ),
                        ],
                      ),
                      onTap: () => _showLanguageDialog(context),
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.logout,
                      title: 'Log out',
                      onTap: () => settingsProvider.shareApp(),
                    ),
                  ],
                ),

                _buildSettingsSection(
                  context,
                  title: 'App Customization',
                  children: [
                    _buildSettingsTile(
                      context,
                      icon: Icons.color_lens_outlined,
                      titleWidget: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Theme',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'System',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF754BE5),
                            ),
                          ),
                        ],
                      ),
                      subtitle: (ThemeMode mode) {
                        // ... (same as original implementation)
                      }(settingsProvider.settings.themeMode),
                      onTap: () => _showThemeDialog(context),
                    ),
                  ],
                ),

                _buildSettingsSection(
                  context,
                  title: 'About App',
                  children: [
                    _buildSettingsTile(
                      context,
                      icon: Icons.star_border,
                      title: 'Rate Us',
                      onTap: () => settingsProvider.rateApp(),
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.shield_outlined,
                      title: 'Privacy Policy',
                      onTap: () => settingsProvider.openPrivacyPolicy(),
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.share_outlined,
                      title: 'Share with Friends',
                      onTap: () => settingsProvider.shareApp(),
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons
                          .info_outline, // Using an "info" icon for app version
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'App version',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '1.0.0',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      onTap: null, // Disable tap action for app version
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create settings sections
  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  // Helper method to create settings tiles
  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    String? title, // Optional, if titleWidget is used
    Widget? titleWidget, // For custom titles
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF754BE5),
        ),
      ),
      title: titleWidget ??
          (title != null
              ? Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )
              : null),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w400),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // Language and Theme dialogs remain the same as in the original implementation
  void _showLanguageDialog(BuildContext context) {
    // ... (same as original implementation)
  }

  void _showThemeDialog(BuildContext context) {
    // ... (same as original implementation)
  }
}
