import 'package:flutter/material.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/firestore.dart';
import 'package:tempoloco/utils/helper.dart';

class DB {
  static String? get uid => Auth.uid;

  static Future<bool> createUser(User user) async {
    try {
      await FirestoreService.instance
          .setData(path: 'user/$uid', data: user.toJson());
      debugPrint("===> [Firestore] Create user: ${user.uid}");
      return true;
    } catch (e) {
      debugPrint("===> [Firestore] Error adding user: $e");
      Helper.snack("Error saving user", e.toString());
      return false;
    }
  }

  static Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      await FirestoreService.instance.updateData(path: 'user/$uid', data: data);
      debugPrint('===> [Firestore] Update user $uid: $data');
    } catch (e) {
      debugPrint("===> [Firestore] Error updating user: $e");
    }
  }

  static Stream<User> get userStream =>
      FirestoreService.instance.documentStream(
        builder: (data, documentId) => User.fromJson(data!, documentId),
        path: 'user/$uid',
      );
}
