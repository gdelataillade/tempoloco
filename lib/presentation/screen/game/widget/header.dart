import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/game/game_state.dart';

class GameHeader extends StatelessWidget {
  final String trackName;
  final String artistName;
  final String imgUrl;

  const GameHeader({
    Key? key,
    required this.trackName,
    required this.artistName,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<GameState>();
    final size = MediaQuery.of(context).size.width * 0.7;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (state.loading.value) {
            return Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(size)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
              ),
            );
          }
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(size)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(size)),
                      child: Image.network(imgUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            },
          );
        }),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                trackName,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                artistName,
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
