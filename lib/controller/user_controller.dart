import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

class UserController extends GetxController {
  final Rx<User> user;

  UserController(this.user);

  @override
  Future<void> onInit() async {
    debugPrint("[UserController] init userId: ${Auth.uid}");
    user.bindStream(DB.userStream);
    super.onInit();
  }

  bool enoughStars(int price) => user.value.nbStars >= price;

  Future<void> likeTrack(String trackId) async {
    Helper.hapticFeedback();

    final favorites = user.value.favorites;

    if (favorites.contains(trackId)) {
      favorites.remove(trackId);
      debugPrint('===> [User] Unliking track: $trackId');
    } else {
      favorites.add(trackId);
      debugPrint('===> [User] Liking track: $trackId');
    }

    await DB.updateUser(user.value.copyWith(favorites: favorites).toJson());
  }

  Future<void> addTrackToHistory(String trackId, double score) async {
    final history = user.value.history;

    if (history.where((item) => item['id'] == trackId).isNotEmpty) {
      history.removeWhere((item) => item['id'] == trackId);
    }

    if (history.length >= 20) history.removeLast();

    debugPrint('===> [User] Adding track to history: $trackId');
    await DB.updateUser(
      user.value.copyWith(history: [
        {
          'trackId': trackId,
          'score': score,
        },
        ...history,
      ]).toJson(),
    );
  }

  Future<void> purchaseTrack(String trackId, String artistId, int price) async {
    final library = user.value.library;
    final artists = user.value.artists;
    final nbStars = user.value.nbStars;

    debugPrint('===> [User] Purchasing track $trackId');
    await DB.updateUser(user.value.copyWith(
      library: [trackId, ...library],
      artists: [
        {"title": trackId, "artist": artistId},
        ...artists,
      ],
      nbStars: nbStars - price,
    ).toJson());
  }

  Future<bool> compareHighscore(String trackId, double score) async {
    final highscores = user.value.highscores;
    final index = highscores.indexWhere((e) => e['trackId'] == trackId);
    bool update = false;

    if (index == -1) {
      debugPrint('===> [User] First highscore: $score');
      update = true;
    } else {
      final highscore = user.value.highscores[index]['score'];

      debugPrint('===> [User] Highscore: $highscore - Actual score: $score');

      if (score > highscore) {
        debugPrint('===> [User] New highscore');
        highscores.removeWhere((e) => e['trackId'] == trackId);
        update = true;
      } else {
        debugPrint('===> [User] Actual highscore not beaten');
      }
    }
    if (update) {
      await DB.updateUser(user.value.copyWith(
        highscores: [
          {'trackId': trackId, 'score': score},
          ...highscores,
        ],
      ).toJson());
    }
    return update;
  }

  Future<void> addFriend(String friendId) async {
    debugPrint('===> [User] Adding friend $friendId');
    await DB.updateUser(user.value.copyWith(
      friends: [friendId, ...user.value.friends],
    ).toJson());
  }
}
