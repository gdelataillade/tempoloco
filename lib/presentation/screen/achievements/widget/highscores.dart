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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(item.score.toStringAsFixed(2)),
              ],
            ),
          );
        },
      ),
    );
  }
}
