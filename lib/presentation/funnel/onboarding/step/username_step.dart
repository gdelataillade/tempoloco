import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';
import 'package:tempoloco/utils/extension/string.dart';
import 'package:tempoloco/utils/intl.dart';

class OnboardingUsernameStep extends StatelessWidget {
  const OnboardingUsernameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            Str.username,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          OnboardingTextInput(
            value: state.username,
            onSubmit: (String name) => state.validateUsername(
              name.trim().toLowerCase().removeSpaces,
            ),
          ),
        ],
      ),
    );
  }
}
