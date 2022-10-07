import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/theme.dart';

class ArtistScreenHeader extends StatelessWidget {
  const ArtistScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ArtistScreenState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: state.imageSize,
          width: state.imageSize,
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
            child: Image.network(state.artist.images!.first.url!),
          ),
        ),
        Container(
          height: state.nameSize,
          alignment: Alignment.bottomCenter,
          child: Text(
            state.artist.name!,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}