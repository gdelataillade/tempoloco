import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/stars.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();

    return FadeIn(
      duration: const Duration(seconds: 1),
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: state.likeTrack,
                icon: Obx(
                  () => Icon(
                    state.liked.value
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    color: Colors.red,
                  ),
                ),
                iconSize: 40,
              ),
              IconButton(
                onPressed: state.restartGame,
                icon: const Icon(Icons.restart_alt),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                    Platform.isAndroid ? Icons.share : CupertinoIcons.share),
                iconSize: 40,
              ),
            ],
          ),
          const GameOverStars(),
          Center(
            child: Text(
              "Awesome !",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 50),
            ),
          ),
          const SizedBox(),
          // Center(child: Text("Player BPM: ${state.playerTempo}")),
          // Center(child: Text("Real BPM: ${state.trackTempo}")),
          // Center(
          //   child: Text(
          //     "Precision: ${state.precision.toStringAsFixed(state.precision.truncateToDouble() == state.precision ? 0 : 1)}%",
          //   ),
          // ),
        ],
      ),
    );
  }
}
