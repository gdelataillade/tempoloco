import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/utils/helper.dart';

class DB {
  static Future<bool> createUser(User user) async {
    try {
      await FirebaseFirestore.instance.collection('user').add(user.toJson());
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
      final uid = Auth.uid;
      await FirebaseFirestore.instance.doc('user/$uid').update(data);
      debugPrint('===> [Firestore] Update user $uid: $data');
    } catch (e) {
      debugPrint("===> [Firestore] Error updating user: $e");
    }
  }
}
