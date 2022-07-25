import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';

class OnboardingPasswordStep extends StatelessWidget {
  const OnboardingPasswordStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        const FadeIn(child: Text("Password")),
        if (state.authType == AuthType.login)
          RawMaterialButton(
            onPressed: state.resetPassword,
            child: const Text("Forgot your password ?"),
          ),
        OnboardingTextInput(
          value: state.password,
          isPassword: true,
          onSubmit: (String password) =>
              state.validatePassword(password.trim()),
        ),
      ],
    );
  }
}
