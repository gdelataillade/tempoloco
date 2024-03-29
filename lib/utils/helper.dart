import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/theme.dart';
import 'package:spotify/spotify.dart' as spotify;

class Helper {
  static Future<void> setup() async {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    hideBottomOverlay();

    await Future.wait([
      Storage.init(),
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    ]);
  }

  static void hideBottomOverlay() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  static String get language => Get.locale!.languageCode;

  static String get countryCode =>
      Platform.localeName.split('_').last.toUpperCase();

  static Locale setDefaultLocale() {
    final localLanguage = Platform.localeName.split('_').first;
    if (localLanguage == 'fr' || localLanguage == 'es') {
      Storage.writeData(settingsBox, 'language', localLanguage);
      return Locale(localLanguage);
    }
    Storage.writeData(settingsBox, 'language', 'en');
    return const Locale('en');
  }

  static bool hasVibrations() =>
      Storage.readData(settingsBox, 'vibrate') ?? true;

  static void hapticFeedback() {
    if (hasVibrations()) HapticFeedback.selectionClick();
  }

  static int getPrice(int popularity) {
    double price = (popularity + 1) / 5;
    return price.toInt() + 1;
  }

  static String getMaxResImage(List<spotify.Image> images) {
    spotify.Image img = images.first;

    for (int i = 1; i < images.length; i++) {
      if (images[i].height! > img.height!) img = images[i];
    }
    return img.url!;
  }

  static String getLowResImage(List<spotify.Image> images) {
    spotify.Image img = images.last;

    if (images.length == 3) img = images[1];
    return img.url!;
  }

  static void snack(
    String title,
    String content, {
    bool error = true,
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      content,
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      duration: duration,
      backgroundColor:
          error ? ktempoRed.withOpacity(0.6) : ktempoYellow.withOpacity(0.6),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      snackPosition: SnackPosition.TOP,
      borderWidth: 2,
    );
  }

  static String formatTrackTitle(String title) {
    List<String> splitted = title.split(' - ');
    splitted = splitted.first.split('(');
    splitted = splitted.first.split(':');
    splitted = splitted.first.split('/');
    return splitted[0];
  }
}
