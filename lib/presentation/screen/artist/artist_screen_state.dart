import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/database.dart';

class ArtistScreenState extends GetxController {
  RxBool showArtistNameInAppBar = false.obs;

  Artist artist = Get.arguments as Artist;
  int page = 0;

  final tracks = <Track>[].obs;
  final userCtrl = Get.find<UserController>();

  final imageSize = Get.size.width - 60;
  final nameSize = 44.0;

  double get headerSize => imageSize + nameSize;

  bool isPurchased(String trackId) =>
      Get.find<UserController>().user.value.library.contains(trackId);

  Future<void> loadTracks() async {
    final res = await DB.searchTracksByArtist(artist.name!, page);

    tracks.addAll(res);
  }

  Future<void> likeTrack(String trackId) async =>
      await userCtrl.likeTrack(trackId);

  Future<void> addTrackToHistory(String trackId) async =>
      await userCtrl.addTrackToHistory(trackId);

  @override
  void onInit() {
    loadTracks();
    super.onInit();
  }
}
