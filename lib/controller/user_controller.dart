import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';

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
    HapticFeedback.mediumImpact();

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

    debugPrint('===> [TabViewState] Purchasing track $trackId');
    await DB.updateUser(user.value.copyWith(
      library: [trackId, ...library],
      artists: [
        {"title": trackId, "artist": artistId},
        ...artists,
      ],
      nbStars: nbStars - price,
    ).toJson());
  }

  // TODO: Implement this feature
  Future<void> addFriend(String friendId) async {
    debugPrint('===> [TabViewState] Adding friend $friendId');
    await DB.updateUser(user.value.copyWith(
      friends: [friendId, ...user.value.friends],
    ).toJson());
  }
}
