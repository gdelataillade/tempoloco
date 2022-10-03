import 'package:flutter/material.dart';

class HomeArtistItem extends StatelessWidget {
  final String name;
  final String imgUrl;
  final double size;

  const HomeArtistItem({
    Key? key,
    required this.name,
    required this.imgUrl,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(size)),
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
            borderRadius: BorderRadius.circular(size / 2),
            child: Image.network(imgUrl, fit: BoxFit.cover),
          ),
        ),
        Flexible(
          child: SizedBox(
            width: size + 20,
            child: Text(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
