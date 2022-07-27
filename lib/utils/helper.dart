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

    await Future.wait([
      Storage.init(),
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    ]);
  }

  static void snack(String title, String content,
      {Duration duration = const Duration(seconds: 4)}) {
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
}
