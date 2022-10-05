import 'package:flutter/material.dart';

class GameTapArea extends StatelessWidget {
  final void Function() onTap;

  const GameTapArea({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: const Text("Tap"),
      ),
    );
  }
}
