import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/database.dart';

class HighscoreItem {
  final String name;
  final double score;

  const HighscoreItem({required this.name, required this.score});
}

class AchievementsState extends GetxController {
  List<HighscoreItem> highscores = [];

  final userCtrl = Get.find<UserController>();

  User get user => userCtrl.user.value;

  Future<void> collectStrikeStars() async {
    debugPrint(
        "[AchievementsState] Collect strikes: ${user.strikes.length} stars");
    await DB.updateUser({
      "hasCollectedStrikes": true,
      "nbStars": user.nbStars + user.strikes.length,
    });
  }

  void buildHighscores(List<spotify.Track> tracks) {
    final highscoreIds = user.highscores.map((e) => e['trackId']).toList();

    for (int i = 0; i < tracks.length; i++) {
      if (highscoreIds.contains(tracks[i].id)) {
        highscores.add(HighscoreItem(
          name: tracks[i].name!,
          score: user.highscores
              .firstWhere((e) => e['trackId'] == tracks[i].id)['score'],
        ));
      }
    }
  }

  @override
  void onInit() {
    final tracks = Get.arguments as List<spotify.Track>;
    debugPrint(tracks.length.toString());

    buildHighscores(tracks);
    super.onInit();
  }
}
