import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/chart_item.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/helper.dart';

class GameState extends GetxController {
  late AudioPlayer audioPlayer;
  late Timer metronome;
  late String previewUrl;
  late RxBool liked;
  late double trackTempo;
  late double playerTempo;
  late double precision;
  late bool isHighscore;

  Track track = Get.arguments as Track;
  int starsEarned = 0;

  final language = Helper.getLanguage();
  final userCtrl = Get.find<UserController>();
  final taps = <Duration>[];
  final accuracyList = <ChartItem>[];

  RxBool loading = true.obs;
  RxBool isOver = false.obs;

  StreamSubscription<PlayerState>? playerStateSub;

  bool get isLiked => userCtrl.isFavorite(track.id!);

  // TODO: Improve algo with standard deviation (delete weird taps)
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

    playerTempo = 1000 * 60 / frequency;
  }

  void setPrecision() {
    precision = playerTempo < trackTempo
        ? playerTempo / trackTempo
        : trackTempo / playerTempo;

    precision *= 100;
  }

  void setStarsEarned() {
    if (precision >= 90) starsEarned++;
    if (precision >= 97) starsEarned++;
    if (precision >= 99) starsEarned++;
  }

  Future<void> addMissingPreviewUrl() async {
    final res =
        await DB.searchTrack("${track.name!} ${track.artists!.first.name}", 0);
    try {
      previewUrl = res.firstWhere((e) => e.id == track.id).previewUrl!;
    } catch (e) {
      debugPrint("[GameState] addMissingPreviewUrl - firstWhere error: $e");
      Get.back();
      Helper.snack(
        "An error has occurred...",
        "The song could not be loaded. Please try again later.",
      );
    }
  }

  // TODO: Use real sound (soundpool)
  Future<void> playMetronome() async {
    final duration = Duration(milliseconds: 1000 ~/ (trackTempo / 60));

    metronome = Timer.periodic(duration, (timer) {
      SystemSound.play(SystemSoundType.click);

      if (!timer.isActive || audioPlayer.playing) timer.cancel();
    });
  }

  Future<void> initAudioPlayer() async {
    if (track.previewUrl == null) {
      await addMissingPreviewUrl();
    } else {
      previewUrl = track.previewUrl!;
    }

    try {
      audioPlayer = AudioPlayer();
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(previewUrl)));
    } catch (e) {
      debugPrint('[GameState] AudioPlayer error => $e ');
      Get.back();
      Helper.snack(
        "An error has occurred...",
        "The song could not be loaded. Please try again later.",
      );
    }

    // Future.delayed(const Duration(seconds: 10), () => onFinish());
  }

  void listenPlayerState() {
    playerStateSub = audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.ready) {
        loading.value = false;
      }
      if (event.processingState == ProcessingState.completed) {
        debugPrint("[Game] audio finished");
        playerStateSub!.cancel();
        onFinish();
      }
    });
  }

  Future<void> getTrackTempo() async {
    trackTempo = await DB.getTrackTempo(track.id!);

    if (trackTempo == 0) {
      Get.back();
      Helper.snack(
        "An error has occurred...",
        "The song could not be loaded. Please try again later.",
      );
    } else {
      playMetronome();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTrackTempo();
    initAudioPlayer();
    listenPlayerState();
    liked = isLiked.obs;
  }

  // TODO: Fix restarted game over
  void restartGame() {
    playMetronome();
    audioPlayer.seek(Duration.zero);
    taps.clear();
    accuracyList.clear();
    starsEarned = 0;
    listenPlayerState();
    isOver.value = false;
  }

  void likeTrack() {
    userCtrl.likeTrack(track.id!);
    liked.toggle();
  }

  Future<void> onTap() async {
    if (!audioPlayer.playing) await audioPlayer.play();

    debugPrint("[Game] onTap");
    taps.add(audioPlayer.position);

    if (taps.length > 1) {
      setPlayerTempo();
      setPrecision();
      accuracyList.add(
        ChartItem(
          accuracy: precision.toPrecision(2),
          position: audioPlayer.position,
        ),
      );
    }
  }

  Future<void> onFinish() async {
    audioPlayer.stop();
    if (Helper.hasVibrations()) HapticFeedback.heavyImpact();
    setPlayerTempo();
    setPrecision();
    setStarsEarned();

    isHighscore =
        await userCtrl.updateUserGameOver(track.id!, precision, starsEarned);
    isOver.value = true;
  }

  @override
  void onClose() {
    debugPrint("[Game] onClose");
    playerStateSub?.cancel();
    audioPlayer.dispose();
    metronome.cancel();
    super.onClose();
  }
}
