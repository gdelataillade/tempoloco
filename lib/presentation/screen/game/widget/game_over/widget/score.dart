import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/widget/feedback.dart';
import 'package:tempoloco/presentation/screen/game/widget/stars.dart';

// TODO: Write more end phrases
class GameOverScore extends StatelessWidget {
  const GameOverScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const GameOverStars(),
        Center(
          child: Text(
            "Awesome !",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 50),
          ),
        ),
        const GameOverFeedback(),
        const SizedBox(),
      ],
    );
  }
}
