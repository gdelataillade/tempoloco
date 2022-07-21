import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';

class OnboardingEmailStep extends StatelessWidget {
  const OnboardingEmailStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingFunnelState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        const FadeIn(child: Text("Email")),
        OnboardingTextInput(
          value: state.email,
          onSubmit: (String email) => state.validateEmail(email.trim()),
        ),
      ],
    );
  }
}
