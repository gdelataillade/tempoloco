import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';
import 'package:tempoloco/utils/modal.dart';

class ArtistScreenTracks extends StatelessWidget {
  const ArtistScreenTracks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ArtistScreenState>();
    return Obx(() {
      if (state.tracks.isEmpty) return const SizedBox();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            final item = state.tracks[index];
            final price = Helper.getPrice(item.popularity!);

            return Column(
              children: [
                TrackCard(
                  id: item.id!,
                  title: item.name!,
                  artist: item.artists!.first.name!,
                  imgUrl: Helper.getLowResImage(item.album!.images!),
                  price: price,
                  onPress: () {
                    if (state.userCtrl.isPurchased(item.id!)) {
                      Get.toNamed('/game', arguments: item);
                    } else {
                      Modal.showPurchaseModal(
                        context,
                        item,
                        price,
                        () => state.purchaseTrack(item.id!, price),
                      );
                      state.tracks.refresh();
                    }
                  },
                  onLike: () => state.likeTrack(item.id!),
                ),
                if (index == state.tracks.length - 1)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(ktempoWhite)),
                  ),
              ],
            );
          },
        ),
      );
    });
  }
}
