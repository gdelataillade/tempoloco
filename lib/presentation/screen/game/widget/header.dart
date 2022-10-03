import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

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
    final size = MediaQuery.of(context).size.width - 60;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: ktempoDark,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(imgUrl),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          trackName,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 10),
        Text(
          artistName,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
