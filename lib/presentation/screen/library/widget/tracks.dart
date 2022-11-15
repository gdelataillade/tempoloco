import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class LibraryTracks extends StatelessWidget {
  const LibraryTracks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.library.isEmpty) {
        return const Loading(debugLabel: 'Library Tracks');
      }
      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.only(top: 10),
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.library.length,
            itemBuilder: (context, index) {
              final item = state.library[index];
              return Column(
                children: [
                  TrackCard(
                    title: item.name!,
                    artist: item.artists!.first.name!,
                    imgUrl: Helper.getMinResImage(item.album!.images!),
                    trackId: item.id!,
                    isPurchased: true,
                    onPress: () {
                      Get.toNamed('/game', arguments: item);
                    },
                    onLike: () => state.likeTrack(item.id!),
                  ),
                  if (index == state.library.length - 1)
                    SizedBox(
                      height: 70,
                      child:
                          Center(child: Text("${state.library.length} songs")),
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
