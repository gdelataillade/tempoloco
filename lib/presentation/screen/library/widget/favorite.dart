import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/utils/helper.dart';

class LibraryFavorite extends StatelessWidget {
  const LibraryFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.library.isEmpty) {
        return const Loading(debugLabel: 'Library Favorite');
      }

      final favorites = state.library
          .where((track) => state.userCtrl.isFavorite(track.id!))
          .toList();

      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: favorites.isEmpty
            ? const Center(child: Text("Empty"))
            : BottomShaderMask(
                child: ListView.builder(
                  itemCount: favorites.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = favorites[index];
                    return TrackCard(
                      id: item.id!,
                      title: item.name!,
                      artist: item.artists!.first.name!,
                      imgUrl: Helper.getMinResImage(item.album!.images!),
                      onPress: () {
                        Get.toNamed('/game', arguments: item);
                      },
                      onLike: () => state.likeTrack(item.id!),
                    );
                  },
                ),
              ),
      );
    });
  }
}
