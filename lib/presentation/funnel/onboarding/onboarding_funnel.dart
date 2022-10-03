import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';

class OnboardingFunnel extends StatefulWidget {
  const OnboardingFunnel({Key? key}) : super(key: key);

  @override
  State<OnboardingFunnel> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingFunnel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingState>(
        init: OnboardingState(),
        builder: (state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              final index = state.stepIndex.value;

              return Stack(
                children: [
                  Center(
                    child: state.isLoading.value
                        ? const Loading(debugLabel: 'On Boarding')
                        : state.steps[index],
                  ),
                  if (index > 0 && index < 3)
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: index == 1 ? state.exitFunnel : state.goPrevStep,
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
