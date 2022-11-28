import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/feedback.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/presentation/screen/game/widget/stars.dart';
import 'package:tempoloco/utils/constant.dart';
import 'package:tempoloco/utils/extension/list.dart';
import 'package:tempoloco/utils/helper.dart';
import 'package:wiredash/wiredash.dart';

class GameOverScore extends StatelessWidget {
  const GameOverScore({Key? key}) : super(key: key);

  void setWiredashParams(BuildContext context, GameState state) {
    Wiredash.of(context).modifyMetaData(
      (metaData) => metaData
        ..custom['Scope'] = 'Game over'
        ..custom['Track name'] = state.track.name
        ..custom['Track artist'] = state.track.artists!.first.name
        ..custom['Track id'] = state.track.id
        ..custom['Score'] = state.precision
        ..custom['Track tempo'] = state.trackTempo
        ..custom['Player tempo'] = state.playerTempo
        ..custom['Language'] = Helper.language
        ..custom['Nb games'] = state.userCtrl.user.value.nbGames,
    );
  }

  // TODO: Translate this
  String getGameOverPhrase(int nbStars) {
    final phrases = gameOverPhrases
        .firstWhere((e) => e['nbStars'] == nbStars)['phrases'] as List<String>;

    return phrases.oneRandom;
  }

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();
    setWiredashParams(context, state);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const GameOverStars(),
        Center(
          child: Text(
            getGameOverPhrase(state.starsEarned),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 50),
          ),
        ),
        const WiredashFeedbackButton(),
        const SizedBox(),
      ],
    );
  }
}
