import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/game_over.dart';
import 'package:tempoloco/presentation/screen/game/widget/header.dart';
import 'package:tempoloco/presentation/screen/game/widget/tap_area.dart';
import 'package:tempoloco/utils/helper.dart';

// TODO: Fix Hero animation overflow
class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GameState>(
      init: GameState(),
      builder: (state) => Scaffold(
        // appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Stack(
            children: [
              const BackButton(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: state.track.id!,
                    child: GameHeader(
                      trackName: state.track.name!,
                      artistName: state.track.artists!.first.name!,
                      imgUrl: Helper.getMaxResImage(state.track.album!.images!),
                    ),
                  ),
                  Expanded(
                    child: state.isOver.value
                        ? const GameOver()
                        : Align(
                            alignment: Alignment.center,
                            child: GameTapArea(onTap: state.onTap),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
