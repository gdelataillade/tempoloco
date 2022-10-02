import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class LibraryTracks extends StatelessWidget {
  const LibraryTracks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.library.isEmpty) return const Loading();
      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.library.length,
          itemBuilder: (context, index) {
            final item = state.library[index];
            return TrackCard(
              title: item.name!,
              artist: item.artists!.first.name!,
              imgUrl: item.album!.images![1].url!,
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