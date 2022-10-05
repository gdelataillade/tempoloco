import 'package:flutter/material.dart';

const Color ktempoPurple = Color.fromARGB(255, 98, 33, 164);
const Color ktempoIndigo = Color(0xff49129A);
const Color ktempoYellow = Color(0xffFFC65C);
const Color ktempoPink = Color(0xff8534A1);
const Color ktempoDark = Color(0xff19033A);
const Color ktempoWhite = Color(0xffF5EEFC);

final ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: ktempoPurple,
  scaffoldBackgroundColor: ktempoPurple,
  appBarTheme: const AppBarTheme(color: ktempoPurple, elevation: 0),
  primaryColor: ktempoPurple,
  focusColor: ktempoPurple,
  fontFamily: 'SF-Pro-Display',
);
