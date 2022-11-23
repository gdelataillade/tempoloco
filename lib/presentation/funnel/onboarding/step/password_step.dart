import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';
import 'package:tempoloco/utils/intl.dart';

class OnboardingPasswordStep extends StatelessWidget {
  const OnboardingPasswordStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        FadeIn(child: Text(Str.password)),
        if (state.authType == AuthType.login)
          RawMaterialButton(
            onPressed: state.resetPassword,
            child: Text(Str.forgotPwd),
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
