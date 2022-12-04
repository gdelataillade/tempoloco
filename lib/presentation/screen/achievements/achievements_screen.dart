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
                    Text(
                      userCtrl.user.value.nbStars.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: ktempoYellow,
                      size: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        FeatherIcons.user,
                        color: ktempoWhite,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'highscores'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const AchievementsHighscores(),
                  const AchievementsStrikes(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
