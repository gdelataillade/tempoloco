import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/home_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeState>(
          init: HomeState(),
          builder: (state) {
            return Center(
              child: RawMaterialButton(
                onPressed: state.signOut,
                child: const Text("Sign Out"),
              ),
            );
          }),
    );
  }
}
