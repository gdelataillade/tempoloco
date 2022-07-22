import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_state.dart';
import 'package:tempoloco/theme.dart';

class OnBoardingMusicStepGenreItem extends StatelessWidget {
  final String genre;
  final String artistPictureUrl;

  const OnBoardingMusicStepGenreItem({
    Key? key,
    required this.genre,
    required this.artistPictureUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<OnboardingState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => state.selectGenre(genre),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  height: 100,
                  width: 100,
                  color: ktempoDark,
                  // decoration: BoxDecoration(
                  //   color: ktempoDark,
                  //   border: Border.all(
                  //       color: isSelected ? ktempoWhite : ktempoIndigo),
                  //   borderRadius: BorderRadius.circular(80),
                  // ),
                  child: Image.network(artistPictureUrl),
                ),
              ),
              Obx(
                () {
                  final isSelected = state.selectedGenres.contains(genre);

                  if (!isSelected) return const SizedBox.shrink();
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.transparent,
                    decoration: BoxDecoration(
                      color: ktempoDark,
                      border: Border.all(color: ktempoWhite),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ],
          ),
        ),
        Text(genre),
      ],
    );
  }
}
