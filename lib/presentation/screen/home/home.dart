import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/home/widget/artists.dart';
import 'package:tempoloco/presentation/screen/home/widget/quick_play.dart';

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
          child:
              Text("Tempoloco", style: Theme.of(context).textTheme.headline2),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Artists", style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeArtists(),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
              Text("Quick play", style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeQuickPlay(),
      ],
    );
  }
}
