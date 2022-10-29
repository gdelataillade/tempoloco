import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_state.dart';
import 'package:tempoloco/theme.dart';

class AchievementsStrikes extends StatelessWidget {
  const AchievementsStrikes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AchievementsState>();

    return Expanded(
      child: Column(
        children: [
          Text("You played ${state.user.strikes.length} day(s) in a row"),
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
                          'Come back tomorrow',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Collect ${state.user.strikes.length} stars",
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
