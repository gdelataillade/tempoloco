import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/intro_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/music_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/username_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/email_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/password_step.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/service/locator.dart';
import 'package:tempoloco/service/storage.dart';
import 'package:tempoloco/utils/constant.dart';
import 'package:tempoloco/utils/helper.dart';

enum AuthType { login, register }

class OnboardingState extends GetxController {
  final steps = <Widget>[const OnboardingIntroStep()].obs;

  String uid = "";
  String username = "";
  String email = "";
  String password = "";

  RxInt stepIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxList<String> selectedGenres = <String>[].obs;

  late AuthType authType;

  @override
  Future<void> onInit() async {
    await persistentLogin();
    super.onInit();
  }

  Future<void> persistentLogin() async {
    final String storedEmail = Storage.readData(credentialsBox, "email") ?? "";
    final String storedPwd = Storage.readData(credentialsBox, "password") ?? "";

    if (storedEmail.isNotEmpty && storedPwd.isNotEmpty) {
      email = storedEmail;
      password = storedPwd;
      await login();
    }
  }

  void startRegister() {
    authType = AuthType.register;

    steps.addAll(
      const [
        OnboardingUsernameStep(),
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
      // TODO: Don't erase password if network error
      Storage.writeData(credentialsBox, "password", "");
      isLoading.value = false;
    } else {
      Storage.writeData(credentialsBox, "email", email);
      Storage.writeData(credentialsBox, "password", password);
      analyticsLct.event("Login");
      Get.offAllNamed('/tabview');
    }
  }

  Future<void> register() async {
    isLoading.value = true;

    debugPrint("[Auth] register with: $email:$password");

    final res = await Auth.register(email, password);

    debugPrint("[Auth] register ${res != null ? "succesful" : "failed"}");

    if (res == null) {
      isLoading.value = false;
      return;
    }

    await Future.wait([
      Auth.updateUsername(username),
      Storage.writeData(credentialsBox, "email", email),
      Storage.writeData(credentialsBox, "password", password),
    ]);

    analyticsLct.event("Register");

    uid = res;
    stepIndex.value++;

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

  void validateUsername(String value) {
    if (value.length < 2) {
      Helper.snack(
        "Password is too short",
        "It should be at least 2 characters",
      );
      return;
    } else if (value.contains('@') || value.contains('.')) {
      Helper.snack(
        "Your name contains weird characters",
        "Please enter a valid name",
      );
      return;
    }
    username = value;
    stepIndex.value++;
  }

  void validateEmail(String value) {
    final bool isValid = EmailValidator.validate(value);

    if (!isValid) {
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
    isLoading.value = true;

    analyticsLct
        .eventWithParams("Genres selected", {"selectedGenres": selectedGenres});

    final tracks = generateTracks();
    final library = createLibrary(tracks);

    User newUser = User(
      uid: uid,
      username: username,
      email: email,
      createdDate: DateTime.now(),
      library: library,
      artists: tracks,
    );

    final res = await DB.createUser(newUser);
    if (res) Get.offAllNamed('/tabview');
  }

  List<Map<String, String>> generateTracks() {
    List<Map<String, String>> res = [];
    final random = Random();

    for (int i = 0; i < selectedGenres.length; i++) {
      final genre =
          onboardingGenres.where((e) => e["genre"] == selectedGenres[i]).first;

      final List tracks = genre["tracks"];

      for (int j = 0; j < tracks.length; j++) {
        res.add(tracks[j]);
      }
    }

    while (res.length > 8) {
      final index = random.nextInt(res.length);
      res.removeAt(index);
    }

    return res;
  }

  List<String> createLibrary(List<Map<String, String>> tracks) {
    List<String> res = [];

    for (int i = 0; i < tracks.length; i++) {
      res.add(tracks[i]["title"]!);
    }

    return res;
  }
}
