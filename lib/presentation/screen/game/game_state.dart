import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/service/database.dart';

class GameState extends GetxController {
  late AudioPlayer audioPlayer;
  late double score;

  Track track = Get.arguments as Track;

  RxBool isOver = false.obs;

  StreamSubscription<PlayerState>? playerStateSub;

  Future<void> addMissingPreviewUrl() async {
    final res = await DB.searchTrack(track.name!, 0);
    track.previewUrl = res.first.previewUrl;
  }

  Future<void> initAudioPlayer() async {
    if (track.previewUrl == null) addMissingPreviewUrl();

    audioPlayer = AudioPlayer();
    await audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse(track.previewUrl!)));

    playerStateSub = audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.loading) {}
      if (event.processingState == ProcessingState.buffering) {}
      if (event.processingState == ProcessingState.ready) {}
      if (event.processingState == ProcessingState.completed) {
        onFinish();
      }
    });
    await audioPlayer.play();
    // Future.delayed(const Duration(seconds: 3), () => onFinish());
  }

  @override
  void onInit() {
    super.onInit();
    initAudioPlayer();
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
    audioPlayer.dispose();
    super.onClose();
  }
}
