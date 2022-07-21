import 'package:flutter/material.dart';
import 'package:tempoloco/common/animation/fade_in.dart';

class OnboardingMusicStep extends StatelessWidget {
  const OnboardingMusicStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        children: const [
          Text("What kind of music do you love ?"),
        ],
      ),
    );
  }
}
