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

  Future<void> likeTrack(String trackId) async {
    HapticFeedback.mediumImpact();

    final favorites = user.value.favorites;

    if (favorites.contains(trackId)) {
      favorites.remove(trackId);
      debugPrint('===> [User] Unliking track $trackId');
    } else {
      favorites.add(trackId);
      debugPrint('===> [User] Liking track $trackId');
    }

    await DB.updateUser(user.value.copyWith(favorites: favorites).toJson());
  }

  // TODO: Implement addToHistory and purchaseTrack here
}
