import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tempoloco/presentation/common/widget/highscore_list.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/friend/friend_state.dart';
import 'package:tempoloco/presentation/screen/friend/widget/delete_button.dart';
import 'package:tempoloco/presentation/screen/friend/widget/header.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackButton(),
            GetX<FriendState>(
              init: FriendState(),
              builder: (state) => state.loading.value == true
                  ? const Loading()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const FriendScreenHeader(),
                          const SizedBox(height: 20),
                          HighscoreList(highscores: state.highscores),
                          const FriendScreenDeleteButton(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
