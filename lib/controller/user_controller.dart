import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/service/locator.dart';
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
  bool isFavorite(String trackId) => user.value.favorites.contains(trackId);
  bool isPurchased(String trackId) => user.value.library.contains(trackId);

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

  Future<bool> updateUserGameOver(
    String trackId,
    double score,
    int starsEarned,
  ) async {
    final history = addTrackToHistory(trackId, score);
    final highscores = compareHighscore(trackId, score);
    final isHighscore = highscores.length == user.value.highscores.length;

    await DB.updateUser(user.value
        .copyWith(
          history: history,
          highscores: highscores,
          nbStars: user.value.nbStars + starsEarned,
        )
        .toJson());

    return isHighscore;
  }

  List<Map<String, dynamic>> addTrackToHistory(String trackId, double score) {
    final history = user.value.history;

    if (history.where((item) => item['trackId'] == trackId).isNotEmpty) {
      history.removeWhere((item) => item['trackId'] == trackId);
    }

    if (history.length >= 20) history.removeLast();

    debugPrint('===> [User] Adding track to history: $trackId');

    return [
      {'trackId': trackId, 'score': score},
      ...history,
    ];
  }

  Future<void> purchaseTrack(String trackId, String artistId, int price) async {
    final library = user.value.library;
    final artists = user.value.artists;
    final nbStars = user.value.nbStars;

    debugPrint('===> [User] Purchasing track $trackId');
    analyticsLct.eventWithParams(
      "Track purchased",
      {
        "trackId": trackId,
        "price": price,
      },
    );

    await DB.updateUser(user.value.copyWith(
      library: [trackId, ...library],
      artists: [
        {"title": trackId, "artist": artistId},
        ...artists,
      ],
      nbStars: nbStars - price,
    ).toJson());
  }

  List<Map<String, dynamic>> compareHighscore(String trackId, double score) {
    final highscores = user.value.highscores;
    final index = highscores.indexWhere((e) => e['trackId'] == trackId);

    if (index == -1) {
      debugPrint('===> [User] First highscore: $score');
      highscores.insert(0, {'trackId': trackId, 'score': score});
    } else {
      final highscore = user.value.highscores[index]['score'];

      debugPrint('===> [User] Highscore: $highscore - Actual score: $score');

      if (score > highscore) {
        debugPrint('===> [User] New highscore');
        highscores.removeWhere((e) => e['trackId'] == trackId);
        highscores.insert(0, {'trackId': trackId, 'score': score});
      } else {
        debugPrint('===> [User] Actual highscore not beaten');
      }
    }

    return highscores;
  }

  Future<void> sendFriendRequest(String username) async {
    debugPrint('===> [c xtgfUser] Sending friend request $username');
    final friend = await DB.getFriend(username);

    await DB.updateUser(
      friend.copyWith(
        friendRequests: [
          user.value.username,
          ...friend.friendRequests,
        ],
      ).toJson(),
      id: friend.uid,
    );
  }

  Future<void> handleFriendRequest(String username, bool accept) async {
    debugPrint('===> [User] ${accept ? 'Adding' : 'Denying'} $username');

    await DB.updateUser(
      user.value
          .copyWith(
            friends:
                accept ? [...user.value.friends, username] : user.value.friends,
            friendRequests: user.value.friendRequests..remove(username),
          )
          .toJson(),
    );

    if (accept) {
      final friend = await DB.getFriend(username);
      await DB.updateUser(
        friend.copyWith(
          friends: [...friend.friends, user.value.username],
        ).toJson(),
        id: friend.uid,
      );
    }
  }
}
