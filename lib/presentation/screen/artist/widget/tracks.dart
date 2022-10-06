import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

// TODO: Reload tracks
class ArtistScreenTracks extends StatefulWidget {
  const ArtistScreenTracks({Key? key}) : super(key: key);

  @override
  State<ArtistScreenTracks> createState() => _ArtistScreenTracksState();
}

class _ArtistScreenTracksState extends State<ArtistScreenTracks> {
  final state = Get.find<ArtistScreenState>();
  final controller = ScrollController();

  void detectEnd() {
    if (controller.position.atEdge) {
      if (controller.position.pixels != 0) {
        state.page += 1;
        state.loadTracks();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(detectEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (state.tracks.isEmpty) return const SizedBox();
      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.tracks.length,
            itemBuilder: (context, index) {
              final item = state.tracks[index];
              return Column(
                children: [
                  TrackCard(
                    title: item.name!,
                    artist: item.artists!.first.name!,
                    imgUrl: item.album!.images![1].url!,
                    trackId: item.id!,
                    isPurchased: state.isPurchased(item.id!),
                    price: Helper.getPrice(item.popularity!),
                    onPress: () {
                      // state.addTrackToHistory(item.id!);
                      // Get.toNamed('/game', arguments: item);
                    },
                    onLike: () {},
                    // onLike: () => state.likeTrack(item.id!),
                  ),
                  if (index == state.tracks.length - 1)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(ktempoWhite)),
                    ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
