import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/header.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameState>(
      init: GameState(),
      builder: (state) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GameHeader(
              trackName: state.track.name!,
              artistName: state.track.artists!.first.name!,
              imgUrl: state.track.album!.images!.first.url!,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("Tap"),
            ),
          ],
        ),
      ),
    );
  }
}
