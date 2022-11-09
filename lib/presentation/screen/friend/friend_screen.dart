import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/friend/friend_state.dart';
import 'package:tempoloco/presentation/screen/friend/widget/header.dart';
import 'package:tempoloco/presentation/screen/friend/widget/highscores.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: GetX<FriendState>(
        init: FriendState(),
        builder: (state) => state.loading.value == true
            ? const Loading()
            : Column(
                children: const [
                  FriendScreenHeader(),
                  FriendScreenHighscores(),
                ],
              ),
      ),
    );
  }
}
