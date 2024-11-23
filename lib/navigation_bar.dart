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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              currentPageIndex == 0
                  ? 'assets/icons/filled/Home.png'
                  : 'assets/icons/outlined/Home.png',
              width: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              currentPageIndex == 1
                  ? 'assets/icons/filled/Calendar.png'
                  : 'assets/icons/outlined/Calendar.png',
              width: 24,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              currentPageIndex == 2
                  ? 'assets/icons/filled/Target.png'
                  : 'assets/icons/outlined/Target.png',
              width: 24,
            ),
            label: 'Target',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              currentPageIndex == 3
                  ? 'assets/icons/filled/Settings.png'
                  : 'assets/icons/outlined/Settings.png',
              width: 24,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: [
        const HomePage(),
        const SchedulePage(),
        const TargetPage(),
        const SettingsPage(),
      ][currentPageIndex],
    );
  }
}
