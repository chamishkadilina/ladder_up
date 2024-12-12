import 'package:flutter/material.dart';

class MyTextTheme {
  MyTextTheme._();

  ///Light Theme
  static TextTheme lightTextTheme = TextTheme(
    // headline
    headlineLarge: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),

    // title
    titleLarge: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),

    // body
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      color: Colors.black.withOpacity(0.5),
    ),

    // label
    labelLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.black.withOpacity(0.5),
    ),
  );

  /// Dark Theme
  static TextTheme darkTextTheme = TextTheme(
    // headline
    headlineLarge: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),

    // title
    titleLarge: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),

    // body
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.5),
    ),

    // label
    labelLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.5),
    ),
  );
}
