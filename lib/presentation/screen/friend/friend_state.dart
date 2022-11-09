import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:tempoloco/model/highscore.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/database.dart';

class FriendState extends GetxController {
  late Rx<User> friend;
  late DrawableRoot svgRoot;

  String username = Get.arguments as String;

  final RxBool loading = true.obs;
  final imageSize = Get.size.width - 60;
  List<HighscoreItem> highscores = [];

  Future<void> loadFriend() async {
    final res = await DB.getFriend(username);
    friend = res.obs;
  }

  Future<void> loadAvatar() async {
    final svgCode = multiavatar(username);
    svgRoot = await svg.fromSvgString(svgCode, username);
  }

  Future<void> loadHighscores() async {
    for (int i = 0; i < friend.value.highscores.length; i++) {
      final highscore = friend.value.highscores[i];
      final track = await DB.getTrackById(highscore['trackId']);

      highscores.add(
        HighscoreItem(name: track.name!, score: highscore['score']),
      );
    }
  }

  @override
  Future<void> onReady() async {
    await Future.wait([
      loadFriend(),
      loadAvatar(),
    ]);
    await loadHighscores();
    loading.value = false;
    super.onReady();
  }
}
