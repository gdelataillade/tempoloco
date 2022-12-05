import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/theme.dart';

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
          const SizedBox(),
          Text(
            'Tempoloco',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 50,
                  color: ktempoYellow,
                  fontWeight: FontWeight.w600,
                ),
          ),
          isTapped
              ? AnimatedOpacity(
                  opacity: isTapped ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
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
                        child: Text(
                          'login'.tr,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    color: ktempoYellow,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                )
              : RawMaterialButton(
                  onPressed: () {
                    setState(() => isTapped = true);
                  },
                  child: Text(
                    'Tap',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          color: ktempoYellow,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
        ],
      ),
    );
  }
}
