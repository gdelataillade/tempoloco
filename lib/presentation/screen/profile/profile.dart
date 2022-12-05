import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/presentation/screen/profile/widget/edit_infos.dart';
import 'package:tempoloco/presentation/screen/profile/widget/friend_list.dart';
import 'package:tempoloco/presentation/screen/profile/widget/friend_requests.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/theme.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ProfileState>(
        init: ProfileState(),
        builder: (state) {
          return SafeArea(
            child: Stack(
              children: [
                const BackButton(color: ktempoYellow),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AvatarCard(
                      size: 150,
                      svgRoot: state.avatarLoaded.value ? state.svgRoot : null,
                    ),
                    const SizedBox(height: 20),
                    const ProfileEditInfos(),
                    const SizedBox(height: 20),
                    const ProfileFriendList(),
                    const ProfileFriendRequests(),
                    const SizedBox(height: 10),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: MainButton(
                        label: 'signOut'.tr,
                        onTap: Auth.signOut,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
