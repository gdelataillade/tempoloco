import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/presentation/screen/profile/widget/add_friend_modal.dart';
import 'package:tempoloco/utils/modal.dart';

// TODO: Refresh list when friend added
class ProfileFriendList extends StatelessWidget {
  const ProfileFriendList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ProfileState>();

    return Obx(
      () => state.friendsLoaded.value
          ? SizedBox(
              height: 120,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Modal.showSimpleModal(
                          context,
                          const AddFriendModal(),
                        ),
                        padding: const EdgeInsets.only(top: 0, right: 8),
                        icon: const Icon(Icons.add_circle_sharp, size: 95),
                        iconSize: 90,
                        splashRadius: 30,
                      ),
                      const SizedBox(height: 6),
                      Text('addFriend'.tr),
                    ],
                  ),
                  Expanded(
                    child: state.friends.isEmpty
                        ? Center(child: Text('checkFriendHighscores'.tr))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.friends.length,
                            itemBuilder: (context, index) {
                              final friend = state.friends[index];

                              return RawMaterialButton(
                                onPressed: () => Get.toNamed(
                                  '/friend',
                                  arguments: friend.username,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    AvatarCard(
                                        size: 80, svgRoot: friend.svgRoot),
                                    const SizedBox(height: 8),
                                    Text(friend.username),
                                  ],
                                ),
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
