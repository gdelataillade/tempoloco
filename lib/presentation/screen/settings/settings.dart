import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/vibrations.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/language.dart';
import 'package:tempoloco/theme.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(color: ktempoYellow)),
      body: GetBuilder<SettingsState>(
        init: SettingsState(),
        builder: (state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'settings'.tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 30),
                  const SettingsLanguage(),
                  const SizedBox(height: 20),
                  const SettingsVibrations(),
                  const Spacer(),
                  // TODO: Fix setState called during build
                  // const WiredashFeedbackButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
