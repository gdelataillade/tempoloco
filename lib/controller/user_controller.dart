import 'package:flutter/material.dart';
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
}
