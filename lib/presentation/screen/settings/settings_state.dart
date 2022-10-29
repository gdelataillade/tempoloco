import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/utils/helper.dart';

class SettingsState extends GetxController {
  Rx<String> language = Helper.getLanguage().obs;
  Rx<bool> vibrations = Helper.hasVibrations().obs;

  void saveVolume(double volume) {
    debugPrint("[Settings] Setting volume to $volume");
    Storage.writeData(settingsBox, 'volume', volume);
  }

  Future<void> setLanguage(String value) async {
    debugPrint("[Settings] Setting language to $value");
    await Storage.writeData(settingsBox, 'language', value);
    language.value = value;
  }

  void toggleVibrations(bool value) {
    debugPrint("[Settings] Setting vibrations to $value");
    Storage.writeData(settingsBox, 'vibrate', value);
    vibrations.value = value;
  }
}
