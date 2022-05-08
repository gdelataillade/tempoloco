import 'package:firebase_auth/firebase_auth.dart';
import 'package:tempoloco/utils/helper.dart';

class Auth {
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
      if (!msg.contains("The password is invalid")) {
        // analyticsLct.logError("Auth", "signInWithEmailAndPassword", msg);
      }
      if (msg.contains("user-not-found")) {
        msg = "This email doesn't exist:\n$email";
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
      // analyticsLct.logError("Auth", "createUserWithEmailAndPassword", msg);
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

  static Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      final msg = e.toString();
      // analyticsLct.logError("Auth", "resetPassword", msg);
      Helper.snack('Oups 🤓', msg);
    }
  }
}
