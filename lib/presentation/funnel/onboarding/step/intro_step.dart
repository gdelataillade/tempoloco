import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/utils/intl.dart';

class OnboardingIntroStep extends StatefulWidget {
  const OnboardingIntroStep({Key? key}) : super(key: key);

  @override
  State<OnboardingIntroStep> createState() => _OnboardingIntroStepState();
}

class _OnboardingIntroStepState extends State<OnboardingIntroStep> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();
    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Tempoloco", style: Theme.of(context).textTheme.titleLarge),
          isTapped
              ? AnimatedOpacity(
                  opacity: isTapped ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        onPressed: state.startRegister,
                        child: Text(Str.register),
                      ),
                      RawMaterialButton(
                        onPressed: state.startLogin,
                        child: Text(Str.login),
                      ),
                    ],
                  ),
                )
              : RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      isTapped = true;
                    });
                  },
                  child: const Text("Tap"),
                ),
        ],
      ),
    );
  }
}
