import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/metronome.json'),
        Text(
          "Tempoloco",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
