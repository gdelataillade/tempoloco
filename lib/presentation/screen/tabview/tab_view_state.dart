import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/extension/datetime.dart';
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
  RxBool noMoreResults = false.obs;

  late UserController userCtrl;

  User get user => userCtrl.user.value;

  bool isFavorite(String trackId) => user.favorites.contains(trackId);
  bool isPurchased(String trackId) => user.library.contains(trackId);

  @override
  Future<void> onInit() async {
    await initUserController();
    await Future.wait([
      loadLibrary(),
      loadArtists(),
    ]);

    ever<User>(userCtrl.user, (_) {
      if (library.length != user.library.length) updateLibrary();
    });

    isLoaded.value = true;

    setStrikes();
    super.onInit();
  }

  Future<void> updateLibrary() async {
    for (int i = 0; i < user.library.length; i++) {
      if (library.where((t) => t.id == user.library[i]).isEmpty) {
        final track = await DB.getTrackById(user.library[i]);

        library.assignAll([track, ...library]);
      }
    }
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

  Future<void> search(String input, {bool clear = false}) async {
    if (searchParams.type == SearchType.tracks) {
      if (clear) searchParams.tracksPage = 0;

      final res = await DB.searchTrack(input, searchParams.tracksPage);
      if (clear) trackResults.clear();
      trackResults.addAll(res);
      if (res.length < 15) noMoreResults.value = true;
    } else {
      final res = await DB.searchArtist(input);
      artistResults.assignAll(res);
      if (res.length < 15) noMoreResults.value = true;
    }
  }

  Future<void> likeTrack(String trackId) => userCtrl.likeTrack(trackId);

  Future<void> purchaseTrack(String trackId, String artistId, int price) =>
      userCtrl.purchaseTrack(trackId, artistId, price);

  Future<void> setStrikes() async {
    final strikes = user.strikes;

    if (strikes.isEmpty || strikes.last.isYesterday) {
      await DB.updateUser({
        "strikes": [
          ...strikes,
          DateTime.now(),
        ],
        "hasCollectedStrikes": false,
      });
    } else if (!strikes.last.isToday) {
      await DB.updateUser({
        "strikes": [DateTime.now()],
        "hasCollectedStrikes": false,
      });
    }
  }
}
