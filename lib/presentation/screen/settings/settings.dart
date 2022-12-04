import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/vibrations.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/language.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

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
                      const Icon(
                        Icons.star_rounded,
                        color: ktempoYellow,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(FeatherIcons.user, color: ktempoWhite, size: 30),
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
