import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/intro_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/music_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/name_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/email_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/password_step.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/utils/constant.dart';
import 'package:tempoloco/utils/helper.dart';

enum AuthType { login, register }

class OnboardingState extends GetxController {
  final steps = <Widget>[const OnboardingIntroStep()].obs;

  String name = "";
  String email = "";
  String password = "";

  RxInt stepIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxList<String> selectedGenres = <String>[].obs;

  late AuthType authType;

  void startRegister() {
    authType = AuthType.register;

    steps.addAll(
      const [
        OnboardingNameStep(),
        OnboardingEmailStep(),
        OnboardingPasswordStep(),
        OnboardingMusicStep(),
      ],
    );
    stepIndex.value++;
  }

  void startLogin() {
    authType = AuthType.login;

    steps.addAll(
      const [
        OnboardingEmailStep(),
        OnboardingPasswordStep(),
      ],
    );
    stepIndex.value++;
  }

  void goPrevStep() => stepIndex.value--;

  void exitFunnel() {
    steps.clear();
    steps.add(const OnboardingIntroStep());
    stepIndex.value = 0;
  }

  Future<void> login() async {
    isLoading.value = true;

    debugPrint("[Auth] login with: $email:$password");

    final res = await Auth.login(email, password);

    debugPrint("[Auth] login ${res ? "succesful" : "failed"}");

    if (!res) {
      isLoading.value = false;
    } else {
      Get.offAllNamed('/home');
    }
  }

  Future<void> register() async {
    isLoading.value = true;

    debugPrint("[Auth] register with: $email:$password");

    final res = await Auth.register(email, password);
    Auth.updateDisplayName(name);

    debugPrint("[Auth] register ${res ? "succesful" : "failed"}");

    if (res) stepIndex.value++;

    isLoading.value = false;
  }

  Future<void> resetPassword() async {
    isLoading.value = true;

    final res = await Auth.resetPassword(email);

    if (res) {
      Helper.snack(
        "Password reset",
        "An email has been sent to $email",
      );
    }
    isLoading.value = false;
  }

  void validateName(String value) {
    if (value.length < 2) {
      Helper.snack(
        "Password is too short",
        "It should be at least 2 characters",
      );
      return;
    }
    name = value.capitalizeFirst!;
    stepIndex.value++;
  }

  void validateEmail(String value) {
    if (!value.contains("@") || !value.contains(".") || value.length < 6) {
      Helper.snack(
        "Email is not valid",
        "Please use a valid email address",
      );
      return;
    }

    email = value;
    stepIndex.value++;
  }

  void validatePassword(String value) {
    if (value.length < 6) {
      Helper.snack(
        "Password is too short",
        "It should be at least 6 characters",
      );
      return;
    }
    if (stupidPasswords.contains(value.toLowerCase())) {
      Helper.snack(
        "Password refused",
        "Using $value as password is not a good idea",
      );
      return;
    }

    password = value;
    authType == AuthType.login ? login() : register();
  }

  void selectGenre(String genre) {
    selectedGenres.contains(genre)
        ? selectedGenres.remove(genre)
        : selectedGenres.add(genre);
  }

  Future<void> saveSelectedGenre() async {
    final library = createLibrary();
    final artists = createArtists(library);

    User newUser = User(
      uid: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdDate: DateTime.now(),
      library: library,
      artists: [],
    );

    final res = await DB.createUser(newUser);
    if (res) Get.offAllNamed('/home');
  }

  List<String> createLibrary() {
    List<String> res = [];
    final random = Random();

    for (int i = 0; i < selectedGenres.length; i++) {
      final genre =
          onboardingGenres.where((e) => e["genre"] == selectedGenres[i]).first;

      final List tracks = genre["tracks"];

      for (int j = 0; j < tracks.length; j++) {
        res.add(tracks[j]["title"]);
      }
    }

    while (res.length > 8) {
      final index = random.nextInt(res.length);
      res.removeAt(index);
    }

    return res;
  }

  List<String> createArtists(List<String> library) {
    List<String> res = [];

    return res;
  }
}
