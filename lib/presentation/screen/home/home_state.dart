import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';

class HomeState extends GetxController {
  RxBool isLoaded = false.obs;

  late UserController userCtrl;

  @override
  Future<void> onInit() async {
    await initUserController();

    isLoaded.value = true;
    super.onInit();
  }

  Future<void> initUserController() async {
    final user = await DB.userStream.first;
    Get.put<UserController>(UserController(user), permanent: true);
    userCtrl = Get.find<UserController>();
  }

  void signOut() => Auth.signOut();
}
