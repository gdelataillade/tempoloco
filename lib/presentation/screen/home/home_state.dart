import 'package:get/get.dart';
import 'package:tempoloco/service/auth.dart';

class HomeState extends GetxController {
  void signOut() => Auth.signOut();
}
