import 'package:flutter/material.dart';

class AchievementsHighscores extends StatelessWidget {
  const AchievementsHighscores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
