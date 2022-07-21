import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';

class OnboardingIntroStep extends StatefulWidget {
  const OnboardingIntroStep({Key? key}) : super(key: key);

  @override
  State<OnboardingIntroStep> createState() => _OnboardingIntroStepState();
}

class _OnboardingIntroStepState extends State<OnboardingIntroStep> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingFunnelState>();
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
                        child: const Text("Sign up"),
                      ),
                      RawMaterialButton(
                        onPressed: state.startLogin,
                        child: const Text("Already have an account? Log in"),
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
