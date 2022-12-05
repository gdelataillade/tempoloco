import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/text_input.dart';
import 'package:tempoloco/theme.dart';

class OnboardingPasswordStep extends StatelessWidget {
  const OnboardingPasswordStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return Stack(
      children: [
        if (state.authType == AuthType.login)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: RawMaterialButton(
                onPressed: state.resetPassword,
                child: Text(
                  'forgotPwd'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ktempoYellow),
                ),
              ),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeIn(
              child: Text(
                'password'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 35,
                      color: ktempoYellow,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            OnboardingTextInput(
              value: state.password,
              isPassword: true,
              onSubmit: (String password) =>
                  state.validatePassword(password.trim()),
            ),
          ],
        ),
      ],
    );
  }
}
