import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/game_over.dart';
import 'package:tempoloco/presentation/screen/game/widget/header.dart';
import 'package:tempoloco/presentation/screen/game/widget/tap_area.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GameState>(
      init: GameState(),
      builder: (state) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const BackButton(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GameHeader(),
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
