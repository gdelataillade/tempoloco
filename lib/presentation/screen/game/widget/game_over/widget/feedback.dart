import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tempoloco/config.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:wiredash/wiredash.dart';

class GameOverFeedback extends StatefulWidget {
  const GameOverFeedback({Key? key}) : super(key: key);

  @override
  State<GameOverFeedback> createState() => _GameOverFeedbackState();
}

class _GameOverFeedbackState extends State<GameOverFeedback> {
  PackageInfo? packageInfo;
  final state = Get.find<GameState>();

  Future<void> getPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => packageInfo = info);
  }

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = state.userCtrl.user.value;

    return packageInfo == null
        ? const SizedBox()
        : Wiredash(
            projectId: 'tempoloco-5fd51p8',
            secret: wiredashSecret,
            feedbackOptions: WiredashFeedbackOptions(
              collectMetaData: (metaData) => metaData
                ..userEmail = user.email
                ..userId = user.uid
                ..buildVersion = packageInfo!.version
                ..buildNumber = packageInfo!.buildNumber
                ..custom['Track name'] = state.track.name
                ..custom['Track id'] = state.track.id
                ..custom['Score'] = state.precision
                ..custom['Track tempo'] = state.trackTempo
                ..custom['Player tempo'] = state.playerTempo
                ..custom['Nb games'] = user.nbGames,
            ),
            child: TextButton(
              onPressed: () {
                Wiredash.of(context).show(inheritMaterialTheme: true);
              },
              child: const Text("Give feedback"),
            ),
          );
  }
}
