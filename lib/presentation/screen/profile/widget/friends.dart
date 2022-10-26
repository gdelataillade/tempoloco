import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';

class ProfileFriends extends StatelessWidget {
  const ProfileFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ProfileState>();

    return Obx(
      () => state.loaded.value
          ? SizedBox(
              height: 120,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: state.friends.length,
                itemBuilder: (context, index) {
                  final friend = state.friends[index];
                  return Column(
                    children: [
                      AvatarCard(size: 80, svgRoot: friend.svgRoot),
                      Text(friend.name),
                    ],
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }
}
