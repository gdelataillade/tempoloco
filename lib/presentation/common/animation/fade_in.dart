import 'dart:async';

import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeIn({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  late Timer timer;
  double opacity = 0;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 1), () {
      if (mounted) setState(() => opacity = 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: widget.duration,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
