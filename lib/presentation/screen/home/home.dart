import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/home/widget/artists.dart';
import 'package:tempoloco/presentation/screen/home/widget/quick_play.dart';
import 'package:tempoloco/utils/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Tempoloco",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
              Text(Str.artists, style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeArtists(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(Str.quickPlay,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeQuickPlay(),
      ],
    );
  }
}
