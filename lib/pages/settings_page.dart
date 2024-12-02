import 'package:flutter/material.dart';
import 'package:ladder_up/providers/auth_provider.dart';
import 'package:ladder_up/widgets/premium_tile.dart';
import 'package:ladder_up/widgets/setting_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                // sign out
                AuthProvider().signOut();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User avatar
            CircleAvatar(
              radius: 64,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 8),

            // User name
            const Text(
              'Chamishka Dilina',
              style: TextStyle(fontSize: 20),
            ),

            // User email
            const Text(
              'chamishka.dev@gmail.com',
              style: TextStyle(color: Colors.grey),
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
            // Language
            SettingTile(
              onTap: () {},
              icon: Icons.language,
              title: 'Language',
              option: 'English',
            ),

            // Notification
            SettingTile(
              onTap: () {},
              icon: Icons.notifications_none,
              title: 'Notification',
              option: 'Enabled',
            ),

            // Theme
            SettingTile(
              onTap: () {},
              icon: Icons.color_lens_outlined,
              title: 'Theme',
              option: 'Light',
            ),

            // Rate us
            SettingTile(
              onTap: () {},
              icon: Icons.star_border,
              title: 'Rate us',
              showArrow: false,
            ),

            // Privacy policy
            SettingTile(
              onTap: () {},
              icon: Icons.shield_outlined,
              title: 'Privacy policy',
              showArrow: false,
            ),

            // Share with friends
            SettingTile(
              onTap: () {},
              icon: Icons.share_outlined,
              title: 'Share with friends',
              showArrow: false,
            ),

            const Spacer(),

            // App version
            const Text(
              'App version: 1.0.0',
              style: TextStyle(
                color: Color(0xFF754BE5),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
