import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/screen/friend/friend_state.dart';

class FriendScreenHeader extends StatelessWidget {
  const FriendScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<FriendState>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          AvatarCard(
            size: 150,
            svgRoot: state.svgRoot,
          ),
          Container(
            height: 45,
            alignment: Alignment.bottomCenter,
            child: Text(
              state.username,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
