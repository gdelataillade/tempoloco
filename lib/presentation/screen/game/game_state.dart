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
  late double trackTempo;
  late double playerTempo;
  late double precision;

  Track track = Get.arguments as Track;

  final language = Helper.getLanguage();
  final userCtrl = Get.find<UserController>();
  final taps = <Duration>[];

  RxBool loading = true.obs;
  RxBool isOver = false.obs;

  StreamSubscription<PlayerState>? playerStateSub;

  bool get isLiked => userCtrl.user.value.favorites.contains(track.id!);

  void setPlayerTempo() {
    if (taps.isEmpty) {
      playerTempo = 0;
      return;
    }

    final timeBetweenTwoTaps = <int>[];

    for (int i = 0; i < taps.length - 1; i++) {
      timeBetweenTwoTaps.add((taps[i + 1] - taps[i]).inMilliseconds);
    }
    final frequency =
        timeBetweenTwoTaps.reduce((a, b) => a + b) / timeBetweenTwoTaps.length;

    playerTempo = audioPlayer.duration!.inMilliseconds / frequency;
  }

  void setPrecision() {
    precision = playerTempo < trackTempo
        ? playerTempo / trackTempo
        : trackTempo / playerTempo;

    precision *= 100;

    if (precision < 50) precision *= 2;
    if (precision < 25) precision *= 4;
  }

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
      if (event.processingState == ProcessingState.ready) {
        loading.value = false;
      }
      if (event.processingState == ProcessingState.completed) {
        // onFinish();
      }
    });

    Future.delayed(const Duration(seconds: 10), () => onFinish());
  }

  Future<void> getTrackTempo() async {
    trackTempo = await DB.getTrackTempo(track.id!);

    if (trackTempo == 0) {
      Get.back();
      Helper.snack(
        "An error has occurred...",
        "The song could not be loaded. Please try again later.",
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    initAudioPlayer();
    getTrackTempo();
    liked = isLiked.obs;
  }

  void restartGame() {}

  void likeTrack() {
    userCtrl.likeTrack(track.id!);
    liked.toggle();
  }

  Future<void> onTap() async {
    if (!audioPlayer.playing) await audioPlayer.play();

    debugPrint("[Game] onTap");
    taps.add(audioPlayer.position);
  }

  void onFinish() {
    debugPrint("[Game] audio finished");
    audioPlayer.stop();
    setPlayerTempo();
    setPrecision();
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
