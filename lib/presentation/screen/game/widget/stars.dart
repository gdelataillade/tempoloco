import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/theme.dart';

class GameOverStars extends StatefulWidget {
  const GameOverStars({Key? key}) : super(key: key);

  @override
  State<GameOverStars> createState() => _GameOverStarsState();
}

class _GameOverStarsState extends State<GameOverStars> {
  final state = Get.find<GameState>();
  int nbStars = 0;

  void setStarsCount() {
    if (state.precision >= 90) nbStars++;
    if (state.precision >= 97) nbStars++;
    if (state.precision >= 99) nbStars++;
  }

  double getAngle(int index) {
    if (nbStars == 2 && index == 0) return -0.1;
    if (nbStars == 2 && index == 1) return 0.1;

    if (nbStars == 3 && index == 0) return -0.4;
    if (nbStars == 3 && index == 2) return 0.4;

    return 0;
  }

  double getPadding(int index) {
    if (nbStars == 3 && index == 1) return 0;
    return 30;
  }

  @override
  void initState() {
    setStarsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < nbStars; i++)
          Transform.rotate(
            angle: getAngle(i),
            child: Padding(
              padding: EdgeInsets.only(top: getPadding(i), left: 5, right: 5),
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
