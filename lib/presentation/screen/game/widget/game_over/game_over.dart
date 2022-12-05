import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/widget/details.dart';
import 'package:tempoloco/presentation/screen/game/widget/game_over/widget/score.dart';
import 'package:tempoloco/theme.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();
    final pageCtrl = PageController();

    return FadeIn(
      duration: const Duration(seconds: 1),
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: state.likeTrack,
                  icon: Obx(
                    () => Icon(
                      state.liked.value
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: ktempoRed,
                    ),
                  ),
                  iconSize: 40,
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: state.restartGame,
                  icon: const Icon(Icons.restart_alt),
                  iconSize: 40,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: PageView(
              controller: pageCtrl,
              children: const [
                GameOverScore(),
                GameOverDetails(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 20,
              child: SmoothPageIndicator(
                controller: pageCtrl,
                count: 2,
                effect: const WormEffect(
                  dotWidth: 13,
                  dotHeight: 13,
                  dotColor: Colors.grey,
                  activeDotColor: ktempoWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
