import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';
import 'package:tempoloco/presentation/screen/achievements/widget/highscores.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: GetBuilder<AchievementsState>(
        init: AchievementsState(),
        builder: (state) {
          return Column(
            children: const [
              Center(child: Text("Achievements")),
              AchievementsHighscores(),
            ],
          );
        },
      ),
    );
  }
}
