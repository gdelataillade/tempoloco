import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/theme.dart';

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

  static String getLanguage() =>
      Storage.readData('settings', 'language') ??
      Platform.localeName.split('_').first ??
      'en';

  static int getPrice(int popularity) {
    double price = (popularity + 1) / 5;
    return price.toInt() + 1;
  }

  static void snack(
    String title,
    String content, {
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      content,
      titleText: Text(
        title,
        style: const TextStyle(
          color: ktempoWhite,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        content,
        style: const TextStyle(
          color: ktempoWhite,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      duration: duration,
      backgroundColor: ktempoDark,
      margin: const EdgeInsets.all(25),
      snackPosition: SnackPosition.TOP,
      borderColor: ktempoDark,
      borderWidth: 2,
    );
  }

  static String formatTrackTitle(String title) {
    List<String> splitted = title.split(" - ");
    splitted = splitted.first.split("(");
    splitted = splitted.first.split(":");
    splitted = splitted.first.split("/");
    return splitted[0];
  }
}
