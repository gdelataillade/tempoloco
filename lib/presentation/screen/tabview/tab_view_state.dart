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

  // TODO: MOVE LATER
  Future<void> addTrackToHistory(spotify.Track track) async {
    if (history.where((t) => t.id == track.id).isNotEmpty) {
      history.removeWhere((t) => t.id == track.id);
    }

    if (history.length >= 15) history.removeLast();
    history.assignAll([track, ...history]);

    final historyIds = history.map((t) => t.id!).toList();

    await DB.updateUser(
      Get.find<UserController>()
          .user
          .value
          .copyWith(history: historyIds)
          .toJson(),
    );
  }
}
