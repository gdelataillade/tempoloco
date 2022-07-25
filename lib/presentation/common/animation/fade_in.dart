import 'dart:async';

import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;

  const FadeIn({Key? key, required this.child}) : super(key: key);

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  late Timer timer;
  double opacity = 0;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 1), () {
      setState(() => opacity = 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: widget.child,
    );
  }
}
