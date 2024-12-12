import 'package:flutter/material.dart';
import 'package:ladder_up/pages/home_page.dart';
import 'package:ladder_up/pages/schedule_page.dart';
import 'package:ladder_up/pages/settings_page.dart';
import 'package:ladder_up/pages/target_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Detect current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: [
        const HomePage(),
        const SchedulePage(),
        const TargetPage(),
        const SettingsPage(),
      ][currentPageIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // a divider line for more visual separation
          Divider(
            height: 0,
            color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
          ),
          BottomNavigationBar(
            currentIndex: currentPageIndex,
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/outlined/Home.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  isDarkMode
                      ? 'assets/icons/filled/dark_mode/Home.png'
                      : 'assets/icons/filled/white_mode/Home.png',
                  width: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/outlined/Schedule.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  isDarkMode
                      ? 'assets/icons/filled/dark_mode/Schedule.png'
                      : 'assets/icons/filled/white_mode/Schedule.png',
                  width: 24,
                ),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/outlined/Target.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  isDarkMode
                      ? 'assets/icons/filled/dark_mode/Target.png'
                      : 'assets/icons/filled/white_mode/Target.png',
                  width: 24,
                ),
                label: 'Target',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/outlined/Settings.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  isDarkMode
                      ? 'assets/icons/filled/dark_mode/Settings.png'
                      : 'assets/icons/filled/white_mode/Settings.png',
                  width: 24,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
