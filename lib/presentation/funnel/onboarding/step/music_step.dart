import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/presentation/funnel/onboarding/widget/genre_item.dart';
import 'package:tempoloco/presentation/screen/home/widget/artist_item.dart';
import 'package:tempoloco/utils/constant.dart';
import 'package:tempoloco/utils/helper.dart';

class OnboardingMusicStep extends StatelessWidget {
  const OnboardingMusicStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            child: Column(
              children: const [
                Text("What kind of music do you like ?"),
                Text("Pick at least two genres."),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              mainAxisSpacing: 30,
              children: [
                for (int i = 0; i < onboardingGenres.length; i++)
                  OnBoardingMusicStepGenreItem(
                    genre: onboardingGenres[i]["genre"]!,
                    artistPictureUrl: onboardingGenres[i]["artistPictureUrl"]!,
                  ),
              ],
            ),
          ),
          Obx(
            () {
              final state = Get.find<OnboardingState>();
              final disable = state.selectedGenres.length < 2;

              return MainButton(
                label: 'Finish',
                disable: disable,
                onTap: () {
                  if (disable) {
                    Helper.snack(
                      "Pick at least two genres",
                      "",
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    state.saveSelectedGenre();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
