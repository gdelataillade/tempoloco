import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/common/widget/loading.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/theme.dart';

class OnboardingFunnel extends StatefulWidget {
  const OnboardingFunnel({Key? key}) : super(key: key);

  @override
  State<OnboardingFunnel> createState() => _OnboardingFunnelState();
}

class _OnboardingFunnelState extends State<OnboardingFunnel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ktempoPurple,
      body: GetBuilder<OnboardingFunnelState>(
        init: OnboardingFunnelState(),
        builder: (state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              final index = state.stepIndex.value;

              return Stack(
                children: [
                  Center(
                    child: state.isLoading.value
                        ? const Loading()
                        : state.steps[index],
                  ),
                  if (index > 0)
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
