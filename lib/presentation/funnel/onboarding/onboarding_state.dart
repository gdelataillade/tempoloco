import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/intro_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/name_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/email_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/password_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/music_step.dart';
import 'package:tempoloco/service/auth.dart';

enum AuthType { login, register }

class OnboardingFunnelState extends GetxController {
  final steps = <Widget>[OnboardingIntroStep()].obs;

  RxInt stepIndex = 0.obs;

  String name = "";
  String email = "";
  String password = "";

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

  void goNextStep() {
    if (stepIndex < steps.length - 1) {
      stepIndex.value++;
    } else {
      authType == AuthType.login ? login() : register();
    }
  }

  void goPrevStep() => stepIndex.value--;

  void exitFunnel() => stepIndex.value = 0;

  Future<void> login() async {
    debugPrint("[Auth] login with: $email:$password");

    final res = await Auth.login(email, password);

    debugPrint("[Auth] login ${res ? "succesful" : "failed"}");
  }

  Future<void> register() async {
    debugPrint("[Auth] register with: $email:$password");

    final res = await Auth.register(email, password);

    debugPrint("[Auth] login ${res ? "succesful" : "failed"}");
  }
}
