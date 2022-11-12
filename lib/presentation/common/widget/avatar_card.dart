import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarCard extends StatelessWidget {
  final double size;
  final DrawableRoot? svgRoot;

  const AvatarCard({Key? key, required this.size, required this.svgRoot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: svgRoot == null
          ? const SizedBox.shrink()
          : CustomPaint(
              painter: AvatarPainter(svgRoot!, Size(size, size)),
              child: Container(),
            ),
    );
  }
}

class AvatarPainter extends CustomPainter {
  final DrawableRoot svgRoot;
  final Size size;

  AvatarPainter(this.svgRoot, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    svgRoot.scaleCanvasToViewBox(canvas, size);
    svgRoot.clipCanvasToViewBox(canvas);
    svgRoot.draw(canvas, Rect.zero);
  }

  @override
  bool shouldRepaint(AvatarPainter oldDelegate) =>
      svgRoot != oldDelegate.svgRoot;
}
