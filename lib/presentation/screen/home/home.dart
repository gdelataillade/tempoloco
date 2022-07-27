import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/home/home_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeState>(
        init: HomeState(),
        builder: (state) {
          if (!state.isLoaded.value) return const Loading();

          return Column(
            children: [
              Text(state.userCtrl.user.name),
              RawMaterialButton(
                onPressed: state.signOut,
                child: const Text("Sign Out"),
              ),
            ],
          );
        },
      ),
    );
  }
}
