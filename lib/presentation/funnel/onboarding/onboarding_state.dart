import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/intro_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/name_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/email_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/password_step.dart';
import 'package:tempoloco/presentation/funnel/onboarding/step/music_step.dart';

class OnboardingFunnelState extends GetxController {
  final steps = <Widget>[OnboardingIntroStep()].obs;
  RxInt stepIndex = 0.obs;

  String name = "";
  String email = "";
  String password = "";

  void startRegister() {
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
    }
  }

  void goPrevStep() => stepIndex.value--;

  void exitFunnel() => stepIndex.value = 0;
}
