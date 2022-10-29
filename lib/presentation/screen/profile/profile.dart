import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/presentation/screen/profile/widget/edit_infos.dart';
import 'package:tempoloco/presentation/screen/profile/widget/friends.dart';
import 'package:tempoloco/service/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: GetX<ProfileState>(
        init: ProfileState(),
        builder: (state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AvatarCard(
                size: 150,
                svgRoot: state.loaded.value ? state.svgRoot : null,
              ),
              const SizedBox(height: 20),
              const ProfileEditInfos(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: ProfileFriends(),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              const MainButton(
                label: 'Sign out',
                onTap: Auth.signOut,
              ),
            ],
          );
        },
      ),
    );
  }
}
