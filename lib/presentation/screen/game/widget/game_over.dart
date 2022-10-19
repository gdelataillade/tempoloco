import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();

    return Column(
      children: [
        Row(
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
            ),
            IconButton(
              onPressed: state.restartGame,
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
        const Center(child: Text("Game Over")),
      ],
    );
  }
}
