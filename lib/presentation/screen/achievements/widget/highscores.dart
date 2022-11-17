import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';

class AchievementsHighscores extends StatelessWidget {
  const AchievementsHighscores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AchievementsState>();
    final scrollCtrl = ScrollController();

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollCtrl,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.highscores.length,
          controller: scrollCtrl,
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(item.score.toStringAsFixed(2)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
