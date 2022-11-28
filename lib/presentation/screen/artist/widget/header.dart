import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class ArtistScreenHeader extends StatelessWidget {
  const ArtistScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ArtistScreenState>();

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: state.artist.id!,
            child: Container(
              height: state.imageSize,
              width: state.imageSize,
              padding: const EdgeInsets.only(top: 5),
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
                child: Image.network(
                  Helper.getMaxResImage(state.artist.images!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (!state.showArtistNameInAppBar.value)
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 8),
              child: Text(
                state.artist.name!,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
        ],
      ),
    );
  }
}
