import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/utils/helper.dart';

class DB {
  static Future<bool> createUser(User user) async {
    try {
      await FirebaseFirestore.instance.collection('user').add(user.toJson());
      debugPrint("===> [Firestore] Add user ${user.name}");
      return true;
    } catch (e) {
      debugPrint("===> [Firestore] Error adding user: $e");
      Helper.snack("Error saving user", e.toString());
      return false;
    }
  }
}
