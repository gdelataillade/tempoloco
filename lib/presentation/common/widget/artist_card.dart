import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final Function() onTap;

  const ArtistCard({
    Key? key,
    required this.name,
    required this.imgUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60 / 2),
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
