import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

class TabViewState extends GetxController {
  RxBool isLoaded = false.obs;

  late UserController userCtrl;

  @override
  Future<void> onInit() async {
    await initUserController();

    isLoaded.value = true;
    super.onInit();
  }

  Future<void> initUserController() async {
    final exists = await DB.checkIfDocExists();
    if (!exists) {
      Helper.snack(
          "Error with your account", "Please complete the registration");
      await Auth.deleteUserAuth();
      return;
    }

    final user = await DB.userStream.first;
    if (user == null) {
      Helper.snack("Error with your account",
          "Could not find your account in Firestore");
      return;
    }
    Get.put<UserController>(UserController(user), permanent: true);
    userCtrl = Get.find<UserController>();
  }
}
