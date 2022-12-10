import 'package:flutter/material.dart';
import 'package:tempoloco/model/highscore.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';

class HighscoreList extends StatelessWidget {
  final List<HighscoreItem> highscores;

  const HighscoreList({Key? key, required this.highscores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollCtrl = ScrollController();

    highscores.sort(((a, b) => b.score.compareTo(a.score)));

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollCtrl,
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: highscores.length,
            controller: scrollCtrl,
            itemBuilder: (context, index) {
              final item = highscores[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.score.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
