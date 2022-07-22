import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:tempoloco/service/auth.dart';

class HomeState extends GetxController {
  void signOut() {
    Auth.signOut();
    Get.offAllNamed('/onboarding');
  }
}
