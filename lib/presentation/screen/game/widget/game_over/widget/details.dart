import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/widget/chart.dart';

class GameOverDetails extends StatelessWidget {
  const GameOverDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Song's bpm: ${state.trackTempo.toPrecision(2)}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Center(
          child: Text(
            "Your bpm: ${state.playerTempo.toPrecision(2)}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Center(
          child: Text(
            "Precision: ${state.precision.toStringAsFixed(state.precision.truncateToDouble() == state.precision ? 0 : 1)}%",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: GameOverScoreChart(items: state.accuracyList),
        ),
      ],
    );
  }
}
