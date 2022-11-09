import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';
import 'package:tempoloco/presentation/screen/achievements/widget/highscores.dart';
import 'package:tempoloco/presentation/screen/achievements/widget/strikes.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

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
      body: GetBuilder<AchievementsState>(
        init: AchievementsState(),
        builder: (state) {
          return Column(
            children: const [
              Center(child: Text("Achievements")),
              AchievementsHighscores(),
              AchievementsStrikes(),
            ],
          );
        },
      ),
    );
  }
}
