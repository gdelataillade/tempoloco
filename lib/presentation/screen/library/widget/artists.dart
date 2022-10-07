import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/artist_card.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';

class LibraryArtists extends StatelessWidget {
  const LibraryArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.artists.isEmpty) {
        return const Loading(debugLabel: 'Library Artists');
      }
      return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.artists.length,
            itemBuilder: (context, index) {
              final artist = state.artists[index];
              return ArtistCard(
                name: artist.name!,
                imgUrl: artist.images!.first.url!,
              );
            },
          ),
        ),
      );
    });
  }
}
