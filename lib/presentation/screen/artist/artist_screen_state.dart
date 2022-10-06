import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/database.dart';

class ArtistScreenState extends GetxController {
  Artist artist = Get.arguments as Artist;
  int page = 0;

  final tracks = <Track>[].obs;

  bool isPurchased(String trackId) =>
      Get.find<UserController>().user.value.library.contains(trackId);

  Future<void> loadTracks() async {
    final res = await DB.searchTracksByArtist(artist.name!, page);

    tracks.addAll(res);
  }

  @override
  void onInit() {
    loadTracks();
    super.onInit();
  }
}
