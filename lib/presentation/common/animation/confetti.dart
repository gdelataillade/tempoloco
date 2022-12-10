import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfettiAnimation extends StatefulWidget {
  final Widget child;
  final bool enable;

  const ConfettiAnimation({
    Key? key,
    required this.child,
    this.enable = true,
  }) : super(key: key);

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool hide = false;

  void startAnimation(Duration duration) {
    Future.delayed(const Duration(milliseconds: 600), () {
      controller!
        ..duration = duration
        ..forward().then((value) => setState(() => hide = true));
    });
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!hide && widget.enable)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Lottie.asset(
              'assets/lottie/confetti.json',
              onLoaded: (composition) => startAnimation(composition.duration),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
