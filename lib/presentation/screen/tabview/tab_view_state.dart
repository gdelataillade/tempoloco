import 'package:flutter/material.dart';
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
  final history = <spotify.Track>[].obs;

  final trackResults = <spotify.Track>[].obs;
  final artistResults = <spotify.Artist>[].obs;

  final searchParams = SearchParams();

  RxBool isLoaded = false.obs;

  late UserController userCtrl;

  User get user => userCtrl.user.value;

  bool isFavorite(String trackId) => user.favorites.contains(trackId);
  bool isPurchased(String trackId) => user.library.contains(trackId);
  bool enoughStars(int price) => user.nbStars < price;

  int getPrice(int popularity) {
    debugPrint('===> [Price] getPrice');

    double price = (popularity + 1) / 5;
    return price.toInt() + 1;
  }

  @override
  Future<void> onInit() async {
    await initUserController();
    await Future.wait([
      loadLibrary(),
      loadArtists(),
    ]);
    loadHistory();

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

  Future<void> loadHistory() async {
    final res = await DB.getHistory();

    history.value = res;
  }

  Future<void> likeTrack(String trackId) async {
    List<String> favorites = userCtrl.user.value.favorites;

    if (favorites.contains(trackId)) {
      favorites.remove(trackId);
    } else {
      favorites.add(trackId);
    }
    debugPrint('===> [TabViewState] Liking track $trackId');
    await DB.updateUser(user.copyWith(favorites: favorites).toJson());
  }

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
    final library = userCtrl.user.value.library;
    final artists = userCtrl.user.value.artists;
    final nbStars = userCtrl.user.value.nbStars;

    debugPrint('===> [TabViewState] Purchasing track $trackId');
    await DB.updateUser(user.copyWith(
      library: [trackId, ...library],
      artists: [
        {"title": trackId, "artist": artistId},
        ...artists,
      ],
      nbStars: nbStars - price,
    ).toJson());

    await Future.wait([
      loadLibrary(),
      loadArtists(),
    ]);
  }

  Future<void> addTrackToHistory(String trackId) async {
    final historyIds = user.history;

    if (historyIds.where((id) => id == trackId).isNotEmpty) {
      historyIds.removeWhere((id) => id == trackId);
    }

    if (historyIds.length >= 15) history.removeLast();

    debugPrint('===> [TabViewState] Adding track to history: $trackId');
    await DB.updateUser(
      Get.find<UserController>()
          .user
          .value
          .copyWith(history: historyIds)
          .toJson(),
    );
  }
}
