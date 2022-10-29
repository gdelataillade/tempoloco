import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/database.dart';

class AchievementsState extends GetxController {
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
}
