import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

class TabViewState extends GetxController {
  RxBool isLoaded = false.obs;
  final library = <spotify.Track>[].obs;

  late UserController userCtrl;

  User get user => userCtrl.user.value;

  bool isFavorite(String trackId) => user.favorites.contains(trackId);

  @override
  Future<void> onInit() async {
    await initUserController();
    await loadLibrary();

    isLoaded.value = true;
    super.onInit();
  }

  @override
  void onReady() {
    ever(userCtrl.user, (_) {
      print("[TabViewState] update");
    });
    super.onReady();
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
    Get.put<UserController>(UserController(user.obs), permanent: true);
    userCtrl = Get.find<UserController>();
  }

  Future<void> loadLibrary() async {
    final tracks = await DB.getTrackListFromLibary();

    library.value = tracks;
  }

  Future<void> likeTrack(String trackId) async {
    List<String> favorites = userCtrl.user.value.favorites;

    if (favorites.contains(trackId)) {
      favorites.remove(trackId);
    } else {
      favorites.add(trackId);
    }
    await DB.updateUser(user.copyWith(favorites: favorites).toJson());
  }
}
