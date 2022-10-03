import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final String debugLabel;

  const Loading({Key? key, this.debugLabel = ''}) : super(key: key);

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
        if (debugLabel.isNotEmpty && kDebugMode)
          Text(
            debugLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
      ],
    );
  }
}
