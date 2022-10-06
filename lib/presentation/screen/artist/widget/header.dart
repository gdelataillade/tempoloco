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
            child: Image.network(state.artist.images!.first.url!),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          state.artist.name!,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
