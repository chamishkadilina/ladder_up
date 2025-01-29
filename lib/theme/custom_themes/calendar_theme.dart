import 'package:flutter/material.dart';
import 'package:ladder_up/theme/custom_themes/text_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarTheme {
  MyCalendarTheme._();

  /// Light Theme
  static CalendarStyle lightCalendarStyle = CalendarStyle(
    todayDecoration: BoxDecoration(
      color: Colors.blueAccent.withValues(alpha: 0.2),
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: Colors.blue.withValues(alpha: 0.7),
      shape: BoxShape.circle,
    ),
    markerDecoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.8),
      shape: BoxShape.circle,
    ),
    markersAlignment: Alignment.bottomCenter,
    markersAnchor: 0.8,
    markerSize: 8,
    markerMargin: const EdgeInsets.symmetric(horizontal: 0.8),
    todayTextStyle: TextStyle(color: Colors.blue.shade700),
    selectedTextStyle: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    weekendTextStyle: TextStyle(color: Colors.red.shade700, fontSize: 16),
    defaultTextStyle: const TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
  );

  /// Dark Theme
  static CalendarStyle darkCalendarStyle = CalendarStyle(
    todayDecoration: BoxDecoration(
      color: Colors.blueAccent.withValues(alpha: 0.2),
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: Colors.blue.withValues(alpha: 0.7),
      shape: BoxShape.circle,
    ),
    markerDecoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.8),
      shape: BoxShape.circle,
    ),
    todayTextStyle: TextStyle(color: Colors.blue.shade700),
    selectedTextStyle: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    weekendTextStyle: TextStyle(color: Colors.orange.shade700, fontSize: 16),
    defaultTextStyle: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  );

  /// Header Style
  static HeaderStyle headerStyle(BuildContext context) {
    return HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
      titleTextStyle: (Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.headlineLarge
              : MyTextTheme.lightTextTheme.headlineLarge) ??
          const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Default style
      leftChevronIcon: Icon(
        Icons.chevron_left,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        size: 30,
      ),
      rightChevronIcon: Icon(
        Icons.chevron_right,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        size: 30,
      ),
    );
  }
}
