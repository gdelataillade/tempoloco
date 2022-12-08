import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/theme.dart';

class OnboardingIntroStep extends StatelessWidget {
  const OnboardingIntroStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();
    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Text(
            'Tempoloco',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 50,
                  color: ktempoYellow,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Column(
            children: [
              SizedBox(
                width: 250,
                child: MainButton(
                  onTap: state.startRegister,
                  label: 'register'.tr,
                ),
              ),
              RawMaterialButton(
                onPressed: state.startLogin,
                child: RichText(
                  text: TextSpan(
                    text: 'already_have_account'.tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'login'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ktempoYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
