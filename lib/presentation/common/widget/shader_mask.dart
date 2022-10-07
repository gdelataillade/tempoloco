import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class BottomShaderMask extends StatelessWidget {
  final Widget child;

  const BottomShaderMask({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            ktempoPurple,
          ],
          stops: [0.0, 0.95, 1.0],
        ).createShader(rect);
      },
      child: child,
    );
  }
}
