import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over.dart';
import 'package:tempoloco/presentation/screen/game/widget/header.dart';
import 'package:tempoloco/presentation/screen/game/widget/tap_area.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GameState>(
      init: GameState(),
      builder: (state) => Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GameHeader(
              trackName: state.track.name!,
              artistName: state.track.artists!.first.name!,
              imgUrl: state.track.album!.images![1].url!,
            ),
            Expanded(
              child: state.isOver.value
                  ? const GameOver()
                  : GameTapArea(onTap: state.onTap),
            ),
          ],
        ),
      ),
    );
  }
}
