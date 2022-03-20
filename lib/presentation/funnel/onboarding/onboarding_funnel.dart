import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/theme/themes.dart';

class OnboardingFunnel extends StatefulWidget {
  const OnboardingFunnel({Key? key}) : super(key: key);

  @override
  State<OnboardingFunnel> createState() => _OnboardingFunnelState();
}

class _OnboardingFunnelState extends State<OnboardingFunnel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kindigo,
      body: GetBuilder<OnboardingFunnelState>(
        init: OnboardingFunnelState(),
        builder: (state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              final index = state.stepIndex.value;

              return Stack(
                children: [
                  Center(child: state.steps[index]),
                  if (index > 0)
                    Align(
                      alignment:
                          index == 0 ? Alignment.topRight : Alignment.topLeft,
                      child: GestureDetector(
                        onTap: index == 0 ? state.exitFunnel : state.goPrevStep,
                        child: Icon(
                          index == 0 ? Icons.close : Icons.arrow_back,
                          size: 32,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
