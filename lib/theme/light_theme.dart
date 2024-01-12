import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'IBMPlexSansArabic',
  primaryColor: const Color(0xFFFB6E3B),
  secondaryHeaderColor: const Color(0xFF03041D),
  disabledColor: const Color(0xFFBEBEC7),
  brightness: Brightness.light,
  hintColor: const Color(0xFF8F8F9A),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFFEF7822))), colorScheme: const ColorScheme.light(primary: Color(0xFFEF7822), secondary: Color(0xFFEF7822)).copyWith(error: const Color(0xFFE84D4F)),
);