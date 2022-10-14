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

class SearchParams {
  SearchType type = SearchType.tracks;
  String input = '';
  String lastInputOnOtherTab = '';
  int tracksPage = 0;
}

class TabViewState extends GetxController {
  final library = <spotify.Track>[].obs;
  final artists = <spotify.Artist>[].obs;

  final trackResults = <spotify.Track>[].obs;
  final artistResults = <spotify.Artist>[].obs;

  final searchParams = SearchParams();
  final language = Helper.getLanguage();

  RxBool isLoaded = false.obs;

  late UserController userCtrl;

  User get user => userCtrl.user.value;

  bool isFavorite(String trackId) => user.favorites.contains(trackId);
  bool isPurchased(String trackId) => user.library.contains(trackId);
  bool enoughStars(int price) => user.nbStars < price;

  @override
  Future<void> onInit() async {
    await initUserController();
    await Future.wait([
      loadLibrary(),
      loadArtists(),
    ]);

    ever<User>(userCtrl.user, (_) {
      print("[TabViewState] user is changed");
    });

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

  Future<void> likeTrack(String trackId) async =>
      await userCtrl.likeTrack(trackId);

  Future<void> search(String input, {bool clear = false}) async {
    if (searchParams.type == SearchType.tracks) {
      if (clear) searchParams.tracksPage = 0;

      final res = await DB.searchTrack(input, searchParams.tracksPage);
      if (clear) trackResults.clear();
      trackResults.addAll(res);
    } else {
      final res = await DB.searchArtist(input);
      artistResults.assignAll(res);
    }
  }

  Future<void> purchaseTrack(String trackId, String artistId, int price) async {
    await userCtrl.purchaseTrack(trackId, artistId, price);

    // await Future.wait([
    //   loadLibrary(),
    //   loadArtists(),
    // ]);
  }

  Future<void> addTrackToHistory(String trackId) async {
    await userCtrl.addTrackToHistory(trackId);

    // loadHistory();
  }
}
