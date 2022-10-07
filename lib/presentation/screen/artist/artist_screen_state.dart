import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/database.dart';

class ArtistScreenState extends GetxController {
  RxBool showArtistNameInAppBar = false.obs;

  Artist artist = Get.arguments as Artist;
  int page = 0;

  final tracks = <Track>[].obs;

  final imageSize = Get.size.width - 60;
  final nameSize = 44.0;

  double get headerSize => imageSize + nameSize;

  bool isPurchased(String trackId) =>
      Get.find<UserController>().user.value.library.contains(trackId);

  Future<void> loadTracks() async {
    final res = await DB.searchTracksByArtist(artist.name!, page);

    tracks.addAll(res);
  }

  Future<void> likeTrack(String trackId) async {
    final userCtrl = Get.find<UserController>();
    List<String> favorites = userCtrl.user.value.favorites;

    if (favorites.contains(trackId)) {
      favorites.remove(trackId);
    } else {
      favorites.add(trackId);
    }

    HapticFeedback.mediumImpact();
    debugPrint('===> [TabViewState] Liking track $trackId');
    await DB.updateUser(
        userCtrl.user.value.copyWith(favorites: favorites).toJson());
  }

  @override
  void onInit() {
    loadTracks();
    super.onInit();
  }
}
