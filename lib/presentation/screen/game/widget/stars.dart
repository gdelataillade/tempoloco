import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/theme.dart';

class GameOverStars extends StatelessWidget {
  const GameOverStars({Key? key}) : super(key: key);

  double getAngle(int stars, int index) {
    if (stars == 2 && index == 0) return -0.1;
    if (stars == 2 && index == 1) return 0.1;

    if (stars == 3 && index == 0) return -0.4;
    if (stars == 3 && index == 2) return 0.4;

    return 0;
  }

  double getPadding(int stars, int index) {
    if (stars == 3 && index == 1) return 0;
    return 30;
  }

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < state.starsEarned; i++)
          Transform.rotate(
            angle: getAngle(state.starsEarned, i),
            child: Padding(
              padding: EdgeInsets.only(
                top: getPadding(state.starsEarned, i),
                left: 5,
                right: 5,
              ),
              child: const Icon(
                Icons.star_rounded,
                color: ktempoYellow,
                size: 80,
              ),
            ),
          ),
      ],
    );
  }
}
