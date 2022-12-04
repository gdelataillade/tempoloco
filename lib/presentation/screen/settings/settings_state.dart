import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/utils/helper.dart';

class SettingsState extends GetxController {
  Rx<bool> vibrations = Helper.hasVibrations().obs;
  Rx<String> language = Helper.language.obs;

  Future<void> setLanguage(String value) async {
    debugPrint('[Settings] Setting language to $value');
    Get.updateLocale(Locale(value));
    language.value = value;
  }

  void toggleVibrations(bool value) {
    debugPrint('[Settings] Setting vibrations to $value');
    Storage.writeData(settingsBox, 'vibrate', value);
    vibrations.value = value;
  }
}
