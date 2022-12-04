import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';

class GameTapArea extends StatelessWidget {
  final void Function() onTap;

  const GameTapArea({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();

    return Obx(
      () => AnimatedOpacity(
        opacity: state.loading.value == true ? 0 : 1,
        duration: const Duration(milliseconds: 400),
        child: MaterialButton(
          onPressed: state.loading.value ? null : onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          splashColor: state.splashColor.value,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: const Text('Tap'),
          ),
        ),
      ),
    );
  }
}
