import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/game/widget/stars.dart';

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
        const SizedBox(),
      ],
    );
  }
}
