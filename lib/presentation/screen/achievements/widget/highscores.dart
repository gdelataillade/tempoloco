import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';

class AchievementsHighscores extends StatelessWidget {
  const AchievementsHighscores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AchievementsState>();

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.highscores.length,
        itemBuilder: (context, index) {
          final item = state.highscores[index];
          // final highscore =
          return Row(
            children: [
              Text(item.name),
              Text(item.score.toString()),
            ],
          );
        },
      ),
    );
  }
}
