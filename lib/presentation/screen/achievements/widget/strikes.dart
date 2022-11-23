import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/intl.dart';

class AchievementsStrikes extends StatelessWidget {
  const AchievementsStrikes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AchievementsState>();

    return Expanded(
      child: Column(
        children: [
          Text(
            Str.strikes.replaceAll('\$', state.user.strikes.length.toString()),
          ),
          const SizedBox(height: 15),
          Obx(() {
            return RawMaterialButton(
              onPressed: () {
                if (state.user.hasCollectedStrikes) return;
                state.collectStrikeStars();
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: state.user.hasCollectedStrikes
                      ? Colors.grey
                      : ktempoWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: state.user.hasCollectedStrikes
                    ? Center(
                        child: Text(
                          Str.comeBackTomorrow,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // "Collect ${state.user.strikes.length} stars",
                            Str.strikesCollect.replaceAll(
                                '\$', state.user.strikes.length.toString()),

                            style: const TextStyle(color: ktempoDark),
                          ),
                          const Icon(Icons.star_rounded, color: ktempoYellow),
                        ],
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
