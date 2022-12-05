import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/extension/string.dart';

class OnboardingUsernameStep extends StatelessWidget {
  const OnboardingUsernameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'username'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 35,
                  color: ktempoYellow,
                  fontWeight: FontWeight.w600,
                ),
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
