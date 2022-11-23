import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/common/widget/feedback.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/vibrations.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/language.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/volume_slider.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';
import 'package:tempoloco/utils/intl.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Helper.hapticFeedback();
              Get.toNamed('/profile');
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: <Widget>[
                      Text(
                        userCtrl.user.value.nbStars.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Icon(Icons.star, color: ktempoYellow, size: 30),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(FeatherIcons.user, color: ktempoWhite),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<SettingsState>(
        init: SettingsState(),
        builder: (state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    Str.settings,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 20),
                  const SettingsVolumeSlider(),
                  const SizedBox(height: 20),
                  const SettingsLanguage(),
                  const SizedBox(height: 20),
                  const SettingsVibrations(),
                  const Spacer(),
                  const WiredashFeedbackButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
