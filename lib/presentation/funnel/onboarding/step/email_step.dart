import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';
import 'package:tempoloco/theme.dart';

class OnboardingEmailStep extends StatelessWidget {
  const OnboardingEmailStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FadeIn(
          child: Text(
            'Email',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 35,
                  color: ktempoYellow,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        OnboardingTextInput(
          value: state.email,
          onSubmit: (String email) => state.validateEmail(email.trim()),
        ),
      ],
    );
  }
}
