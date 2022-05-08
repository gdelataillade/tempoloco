import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/theme/themes.dart';

class Helper {
  static void setup() {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  static void snack(String title, String content) {
    Get.snackbar(
      title,
      content,
      titleText: Text(
        title,
        style: TextStyle(
          color: ktempoWhite,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        content,
        style: TextStyle(
          color: ktempoWhite,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      backgroundColor: ktempoDark,
      margin: const EdgeInsets.all(25),
      snackPosition: SnackPosition.TOP,
      borderColor: ktempoDark,
      borderWidth: 2,
    );
  }
}
