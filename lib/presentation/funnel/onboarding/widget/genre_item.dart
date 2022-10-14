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

    return Obx(() {
      final isSelected = state.selectedGenres.contains(genre);

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
                    child: Image.network(artistPictureUrl, fit: BoxFit.cover),
                  ),
                ),
                if (isSelected)
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: ktempoWhite, width: 3),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: const SizedBox.expand(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            genre,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w300),
          ),
        ],
      );
    });
  }
}
