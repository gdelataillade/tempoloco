import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class LibraryFavorite extends StatelessWidget {
  const LibraryFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.library.isEmpty) return const Loading();

      final favorites =
          state.library.where((track) => state.isFavorite(track.id!)).toList();

      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: favorites.isEmpty
            ? const Center(child: Text("Empty"))
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return TrackCard(
                    title: item.name!,
                    artist: item.artists!.first.name!,
                    imgUrl: item.album!.images!.last.url!,
                    trackId: item.id!,
                    onPress: () {},
                    onLike: () => state.likeTrack(item.id!),
                  );
                },
              ),
      );
    });
  }
}
