import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/intro_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/music_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/name_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/email_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/password_step.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/utils/constant.dart';
import 'package:tempoloco/utils/helper.dart';

enum AuthType { login, register }

class OnboardingFunnelState extends GetxController {
  final steps = <Widget>[const OnboardingIntroStep()].obs;

  String name = "";
  String email = "";
  String password = "";

  RxInt stepIndex = 0.obs;
  RxBool isLoading = false.obs;

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

  Future<bool> login() async {
    debugPrint("[Auth] login with: $email:$password");

    final res = await Auth.login(email, password);

    debugPrint("[Auth] login ${res ? "succesful" : "failed"}");
    return res;
  }

  Future<void> register() async {
    debugPrint("[Auth] register with: $email:$password");

    final res = await Auth.register(email, password);

    debugPrint("[Auth] login ${res ? "succesful" : "failed"}");
    if (res) {
      stepIndex.value++;
    }
  }

  void validateName(String value) {
    if (value.length < 2) {
      Helper.snack(
        "Password is too short",
        "It should be at least 2 characters",
      );
      return;
    }
    name = value;
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
}
