import 'dart:async';

import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const FadeIn({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  late Timer timer;
  double opacity = 0;

  Future<void> initTimer() async {
    await Future.delayed(widget.delay, () {
      timer = Timer(const Duration(milliseconds: 1), () {
        if (mounted) setState(() => opacity = 1);
      });
    });
  }

  @override
  void initState() {
    initTimer();

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
