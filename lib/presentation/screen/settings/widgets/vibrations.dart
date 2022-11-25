import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/theme.dart';

class SettingsVibrations extends StatelessWidget {
  const SettingsVibrations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<SettingsState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('vibrations'.tr, style: Theme.of(context).textTheme.titleLarge),
        Obx(
          () => CupertinoSwitch(
            value: state.vibrations.value,
            onChanged: state.toggleVibrations,
            activeColor: ktempoPink,
          ),
        ),
      ],
    );
  }
}
