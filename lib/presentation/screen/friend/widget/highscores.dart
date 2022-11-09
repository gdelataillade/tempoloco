import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/friend/friend_state.dart';

class FriendScreenHighscores extends StatelessWidget {
  const FriendScreenHighscores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<FriendState>();

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.highscores.length,
        itemBuilder: (context, index) {
          final item = state.highscores[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(item.score.toStringAsFixed(2)),
              ],
            ),
          );
        },
      ),
    );
  }
}
