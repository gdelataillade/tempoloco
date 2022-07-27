import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
      if (!msg.contains("The password is invalid")) {}
      if (msg.contains("user-not-found")) {
        msg = "No account created with\n$email";
      } else if (msg.contains("wrong-password")) {
        msg = "Wrong password";
      } else if (msg.contains("network-request-failed")) {
        msg = "Network request failed";
      } else if (msg.contains("too-many-requests")) {
        msg = "Too many requests. Please try again later.";
      }
      Helper.snack('Login error', msg);
      return false;
    }
  }

  static Future<bool> register(String email, String pwd) async {
    try {
      final UserCredential res =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      return res.user != null;
    } catch (e) {
      String msg = e.toString();
      if (msg.contains("email-already-in-use")) {
        msg = "This email is already associated with an account.";
      } else if (msg.contains("network-request-failed")) {
        msg =
            "Erreur de connexion avec le serveur.\nÊtes-vous connecté à internet?";
      }
      Helper.snack('Register error', msg);
      return false;
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
        msg = "Email address do not exist";
      }
      Helper.snack("Reset password error", "Email address do not exist");
      return false;
    }
  }

  static Future<void> signOut() async {
    await Future.wait([
      Storage.writeData("credentials", "password", ""),
      FirebaseAuth.instance.signOut(),
    ]);

    Get.offAllNamed('/onboarding');
  }

  static Future<void> deleteUserAuth() async =>
      await FirebaseAuth.instance.currentUser?.delete();

  static Future<void> updateDisplayName(String name) async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    }
  }
}
