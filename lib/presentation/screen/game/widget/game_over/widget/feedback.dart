import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/utils/helper.dart';
import 'package:wiredash/wiredash.dart';

class GameOverFeedback extends StatefulWidget {
  const GameOverFeedback({Key? key}) : super(key: key);

  @override
  State<GameOverFeedback> createState() => _GameOverFeedbackState();
}

class _GameOverFeedbackState extends State<GameOverFeedback> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = Get.find<GameState>();
            final user = state.userCtrl.user.value;

            Wiredash.of(context).setUserProperties(
              userEmail: user.email,
              userId: user.uid,
            );
            Wiredash.of(context).setBuildProperties(
              buildNumber: snapshot.data!.buildNumber,
              buildVersion: snapshot.data!.version,
            );
            Wiredash.of(context).modifyMetaData(
              (metaData) => metaData
                ..custom['Scope'] = "Game over"
                ..custom['Track name'] = state.track.name
                ..custom['Track artist'] = state.track.artists!.first.name
                ..custom['Track id'] = state.track.id
                ..custom['Score'] = state.precision
                ..custom['Track tempo'] = state.trackTempo
                ..custom['Player tempo'] = state.playerTempo
                ..custom['Language'] = Helper.getLanguage()
                ..custom['Nb games'] = user.nbGames,
            );

            return TextButton(
              onPressed: () =>
                  Wiredash.of(context).show(inheritMaterialTheme: true),
              child: const Text("Give feedback"),
            );
          }
          return const SizedBox();
        });
  }
}
