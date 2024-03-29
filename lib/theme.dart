import 'package:flutter/material.dart';

// TODO: Checkout Material 3
const Color ktempoPurple = Color(0xFF4E2151);
const Color ktempoIndigo = Color(0xff49129A);
const Color ktempoYellow = Color(0xFFF7B801);
const Color ktempoRed = Color(0xFFCD4631);
const Color ktempoPink = Color(0xff8534A1);
const Color ktempoDark = Color(0xff19033A);
const Color ktempoWhite = Color(0xffF5EEFC);
const Color ktempoGrey = Color(0xFFCED0CE);

final ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: ktempoPurple,
  scaffoldBackgroundColor: ktempoPurple,
  appBarTheme: const AppBarTheme(color: ktempoPurple, elevation: 0),
  primaryColor: ktempoPurple,
  focusColor: ktempoPurple,
  fontFamily: 'SF-Pro-Display',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
  //   titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
  //   titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  //   bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  //   bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  //   bodySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  // ),
);
