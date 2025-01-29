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

  final List<Widget> _pages = [
    const HomePage(),
    const SchedulePage(),
    const TargetPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
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
                'assets/icons/filled/Home.png',
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
                'assets/icons/filled/Schedule.png',
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
                'assets/icons/filled/Target.png',
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
                'assets/icons/filled/Settings.png',
                width: 24,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
