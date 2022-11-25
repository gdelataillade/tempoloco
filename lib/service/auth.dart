import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/service/locator.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/utils/helper.dart';

class Auth {
  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static String? get uid => FirebaseAuth.instance.currentUser?.uid;

  static Future<bool> login(String email, String pwd) async {
    try {
      final UserCredential res =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      return res.user != null;
    } catch (e) {
      String msg = e.toString();
      if (!msg.contains('The password is invalid')) {}
      if (msg.contains('user-not-found')) {
        // TODO: Go back to email input step
        msg = 'account_do_not_exists'.trParams({'email': email});
      } else if (msg.contains("wrong-password")) {
        msg = 'wrong_password'.tr;
      } else if (msg.contains("network-request-failed")) {
        msg = 'network_error'.tr;
      } else if (msg.contains("too-many-requests")) {
        msg = 'too_many_requests'.tr;
      }
      Helper.snack('login_error'.tr, msg);
      return false;
    }
  }

  static Future<String?> register(String email, String pwd) async {
    try {
      final UserCredential res =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      if (res.user == null) return null;
      return res.user!.uid;
    } catch (e) {
      String msg = e.toString();
      if (msg.contains('email-already-in-use')) {
        msg = 'email_already_taken'.tr;
      } else if (msg.contains('network-request-failed')) {
        msg = 'network_error'.tr;
      }
      Helper.snack('register_error'.tr, msg);
      return null;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Storage.writeData("credentials", "password", "");
      return true;
    } catch (e) {
      String msg = e.toString();
      if (msg.contains("invalid-email")) {
        msg = 'email_do_not_exists'.tr;
      }
      Helper.snack('reset_password_error'.tr, msg);
      return false;
    }
  }

  static Future<void> signOut() async {
    analyticsLct.event("Sign Out");
    await Get.deleteAll();

    await Future.wait([
      Storage.writeData("credentials", "password", ""),
      FirebaseAuth.instance.signOut(),
    ]);

    Get.offAllNamed('/onboarding');
    debugPrint("[Auth] sign out");
  }

  static Future<void> deleteUserAuth() async {
    await Storage.writeData("credentials", "password", "");
    await FirebaseAuth.instance.currentUser?.delete();

    debugPrint("[Auth] delete auth and sign out");
    Get.offAllNamed('/onboarding');
  }

  static Future<void> updateUsername(String username) async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    }
  }

  static Future<bool> updateEmail(String email) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      debugPrint("[Auth] Update email: $email");
      return true;
    } catch (e) {
      String msg = e.toString();
      if (msg.contains("invalid-email")) {
        msg = 'emailNotValid'.tr;
      } else if (msg.contains("email-already-in-use")) {
        msg = 'email_already_taken'.tr;
      } else if (msg.contains("requires-recent-login")) {
        msg = 'try_again_later'.tr;
      }
      Helper.snack('update_email_error'.tr, msg);
      return false;
    }
  }
}
