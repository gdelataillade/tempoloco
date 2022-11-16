import 'package:flutter/material.dart';
import 'package:tempoloco/utils/helper.dart';

class HomeArtistItem extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final double size;
  final Function() onTap;

  const HomeArtistItem({
    Key? key,
    required this.id,
    required this.name,
    required this.imgUrl,
    this.size = 80,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helper.hapticFeedback();
        onTap();
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
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
          ),
          Flexible(
            child: SizedBox(
              width: size + 20,
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
