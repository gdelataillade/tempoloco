import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/theme.dart';

class SettingsVolumeSlider extends StatefulWidget {
  const SettingsVolumeSlider({Key? key}) : super(key: key);

  @override
  State<SettingsVolumeSlider> createState() => _SettingsVolumeSliderState();
}

class _SettingsVolumeSliderState extends State<SettingsVolumeSlider> {
  final state = Get.find<SettingsState>();
  late double volume;

  Timer? debounce;

  void changeVolume(double value) {
    setState(() => volume = value);

    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(
        const Duration(milliseconds: 1000), () => state.saveVolume(volume));
  }

  @override
  void initState() {
    super.initState();
    volume = Storage.readData(settingsBox, 'volume') ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 1,
      value: volume,
      onChanged: changeVolume,
      activeColor: ktempoWhite,
      inactiveColor: ktempoWhite,
    );
  }
}
