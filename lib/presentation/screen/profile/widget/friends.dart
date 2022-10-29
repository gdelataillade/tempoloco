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
              child: Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: state.addFriend,
                        padding: const EdgeInsets.only(top: 0, right: 8),
                        icon: const Icon(Icons.add_circle_sharp, size: 95),
                        iconSize: 90,
                        splashRadius: 30,
                      ),
                      const SizedBox(height: 6),
                      const Text("Add friend"),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.friends.length,
                      itemBuilder: (context, index) {
                        final friend = state.friends[index];
                        return Column(
                          children: [
                            const SizedBox(height: 8),
                            AvatarCard(size: 80, svgRoot: friend.svgRoot),
                            const SizedBox(height: 8),
                            Text(friend.username),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
