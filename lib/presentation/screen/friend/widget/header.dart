import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/screen/friend/friend_state.dart';

class FriendScreenHeader extends StatelessWidget {
  const FriendScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<FriendState>();

    return Column(
      children: [
        AvatarCard(
          size: 150,
          svgRoot: state.svgRoot,
        ),
        const SizedBox(height: 20),
        Text(
          state.username,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
        ),
      ],
    );
  }
}
