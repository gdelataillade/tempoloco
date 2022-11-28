import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';
import 'package:tempoloco/utils/helper.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();
    final size = MediaQuery.of(context).size.width * 0.6;

    final image = Image.network(
      Helper.getMaxResImage(state.track.album!.images!),
      fit: BoxFit.cover,
    );

    Widget imagePlaceholder() {
      return Container(
        height: size,
        width: size,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(size)),
            child: image,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: state.track.id!,
          child: Obx(() {
            if (state.loading.value) return imagePlaceholder();
            return StreamBuilder<Duration>(
              stream: state.audioPlayer.positionStream,
              builder: (context, snapshot) {
                Duration? duration;
                bool hasError = false;

                if (snapshot.hasError) hasError = true;
                if (snapshot.connectionState == ConnectionState.active) {
                  duration = snapshot.data;
                }

                return CustomPaint(
                  foregroundPainter: duration != null && !hasError
                      ? GameHeaderProgressionPainter(
                          height: size,
                          progression: 100 *
                              duration.inMilliseconds /
                              state.audioPlayer.duration!.inMilliseconds,
                        )
                      : null,
                  child: Container(
                    height: size,
                    width: size,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(size)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(size)),
                        child: image,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.track.name!,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                state.track.artists!.first.name!,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GameHeaderProgressionPainter extends CustomPainter {
  final double height;
  final double progression;

  GameHeaderProgressionPainter({
    required this.height,
    required this.progression,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    double arcAngle = 2 * pi * (progression / 100);

    canvas.drawArc(
      Rect.fromLTRB(0, 0, height, height),
      -pi / 2,
      arcAngle,
      false,
      complete,
    );
  }

  @override
  bool shouldRepaint(GameHeaderProgressionPainter oldDelegate) =>
      progression != oldDelegate.progression;
}
