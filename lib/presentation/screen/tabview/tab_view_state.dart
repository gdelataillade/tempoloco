import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

enum SearchType {
  tracks,
  artists,
}

class TabViewState extends GetxController {
  final library = <spotify.Track>[].obs;
  final artists = <spotify.Artist>[].obs;
  final results = <spotify.Track>[].obs;

  final searchType = SearchType.tracks;

  RxBool isLoaded = false.obs;

  late UserController userCtrl;

  User get user => userCtrl.user.value;

  bool isFavorite(String trackId) => user.favorites.contains(trackId);

  @override
  Future<void> onInit() async {
    await initUserController();
    await loadLibrary();
    await loadArtists();

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
    Get.put<UserController>(UserController(user.obs), permanent: true);
    userCtrl = Get.find<UserController>();
  }

  Future<void> loadLibrary() async {
    final res = await DB.getTrackListFromLibary();

    library.value = res;
  }

  Future<void> loadArtists() async {
    final res = await DB.getArtistListFromLibary();

    artists.value = res;
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

  Future<void> search(String input) async {
    if (searchType == SearchType.tracks) {
      results.value = await DB.searchTrack(input);
    } else {
      // res = await DB.getArtistListFromLibary();
    }
  }
}
