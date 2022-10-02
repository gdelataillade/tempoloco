import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/screen/settings/widgets/volume_slider.dart';
import 'package:tempoloco/theme.dart';

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
              HapticFeedback.selectionClick();
              Get.offAllNamed('/profile');
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: <Widget>[
                      Text(userCtrl.user.value.nbStars.toString()),
                      const Icon(Icons.star, color: ktempoYellow),
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
      body: Column(
        children: [
          Text(
            "Settings",
            style: Theme.of(context).textTheme.headline3,
          ),
          const SettingsVolumeSlider(),
        ],
      ),
    );
  }
}
