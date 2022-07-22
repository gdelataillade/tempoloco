import 'package:flutter/material.dart';
import 'package:tempoloco/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/genre_item.dart';
import 'package:tempoloco/utils/constant.dart';

class OnboardingMusicStep extends StatelessWidget {
  const OnboardingMusicStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(child: Text("What kind of music do you love ?")),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              mainAxisSpacing: 30,
              children: [
                for (int i = 0; i < onboardingArtists.length; i++)
                  OnBoardingMusicStepGenreItem(
                    genre: onboardingArtists[i]["genre"]!,
                    artistPictureUrl: onboardingArtists[i]["artistPictureUrl"]!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
