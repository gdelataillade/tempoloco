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
    return GetX<AchievementsState>(
      init: AchievementsState(),
      builder: (state) {
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
                      child: Icon(FeatherIcons.user, color: ktempoWhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Achievements",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 30),
                const AchievementsHighscores(),
                const SizedBox(height: 10),
                const AchievementsStrikes(),
              ],
            ),
          ),
        );
      },
    );
  }
}
