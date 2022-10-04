import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/database.dart';

class GameState extends GetxController {
  late AudioPlayer audioPlayer;
  late double score;

  Track track = Get.arguments as Track;

  RxBool isOver = false.obs;

  StreamSubscription<PlayerState>? playerStateSub;

  Future<void> initAudioPlayer() async {
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
    // await audioPlayer.play();
    Future.delayed(const Duration(seconds: 3), () => onFinish());
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
    addTrackToHistory();
    isOver.value = true;
  }

  // TODO: Find a way to reload home history
  Future<void> addTrackToHistory() async {
    final userCtrl = Get.find<UserController>();
    final history = userCtrl.user.value.history;

    if (history.where((id) => id == track.id).isNotEmpty) {
      history.removeWhere((id) => id == track.id);
    }

    if (history.length >= 15) history.removeLast();

    await DB.updateUser(
      Get.find<UserController>().user.value.copyWith(history: history).toJson(),
    );
  }

  @override
  void onClose() {
    debugPrint("[Game] dispose player");
    audioPlayer.dispose();
    super.onClose();
  }
}
