import 'package:flutter/material.dart';

class GameTapArea extends StatelessWidget {
  final void Function() onTap;

  const GameTapArea({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Tap"));
  }
}
