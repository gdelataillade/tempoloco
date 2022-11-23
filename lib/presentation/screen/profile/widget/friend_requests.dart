import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/utils/intl.dart';

class ProfileFriendRequests extends StatelessWidget {
  const ProfileFriendRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ProfileState>();

    return Obx(
      () => Expanded(
        child: state.friendRequests.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: state.friendRequests.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.friendRequests[index]),
                        const Spacer(),
                        RawMaterialButton(
                          onPressed: () => state.friendRequest(
                            state.friendRequests[index],
                            true,
                          ),
                          child: Text(Str.accept),
                        ),
                        RawMaterialButton(
                          onPressed: () => state.friendRequest(
                            state.friendRequests[index],
                            false,
                          ),
                          child: Text(Str.deny),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
