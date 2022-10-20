import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

class GameState extends GetxController {
  late AudioPlayer audioPlayer;
  late String previewUrl;
  late double score;
  late RxBool liked;

  Track track = Get.arguments as Track;

  final language = Helper.getLanguage();
  RxBool isOver = false.obs;

  final userCtrl = Get.find<UserController>();

  StreamSubscription<PlayerState>? playerStateSub;

  bool get isLiked => userCtrl.user.value.favorites.contains(track.id!);

  Future<void> addMissingPreviewUrl() async {
    final res = await DB.searchTrack(track.name!, 0);
    previewUrl = res.first.previewUrl!;
  }

  Future<void> initAudioPlayer() async {
    if (track.previewUrl == null) {
      await addMissingPreviewUrl();
    } else {
      previewUrl = track.previewUrl!;
    }

    audioPlayer = AudioPlayer();

    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(previewUrl)));
    } catch (e) {
      debugPrint('[GameState] setAudioSource Error => $e ');
      Get.back();
      Helper.snack(
        "An error has occurred...",
        "The song could not be loaded. Please try again later.",
      );
    }

    playerStateSub = audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.loading) {}
      if (event.processingState == ProcessingState.buffering) {}
      if (event.processingState == ProcessingState.ready) {}
      if (event.processingState == ProcessingState.completed) {
        onFinish();
      }
    });

    await audioPlayer.play();
    Future.delayed(const Duration(seconds: 33), () => onFinish());
  }

  @override
  void onInit() {
    super.onInit();
    initAudioPlayer();
    liked = isLiked.obs;
  }

  void restartGame() {}

  void likeTrack() {
    userCtrl.likeTrack(track.id!);
    liked.toggle();
  }

  void onTap() async {
    debugPrint("[Game] onTap");
  }

  Future<void> onFinish() async {
    debugPrint("[Game] audio finished");
    audioPlayer.stop();
    isOver.value = true;
  }

  @override
  void onClose() {
    debugPrint("[Game] dispose player");
    playerStateSub?.cancel();
    audioPlayer.dispose();
    super.onClose();
  }
}
