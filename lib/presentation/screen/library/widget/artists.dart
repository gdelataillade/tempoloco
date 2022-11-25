import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/artist_card.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/utils/helper.dart';

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
              return Column(
                children: [
                  ArtistCard(
                    id: artist.id!,
                    name: artist.name!,
                    imgUrl: Helper.getMinResImage(artist.images!),
                    onTap: () => Get.toNamed('artist', arguments: artist),
                  ),
                  if (index == state.artists.length - 1)
                    SizedBox(
                      height: 70,
                      child: Center(
                        child: Text(
                          '${state.artists.length} artists',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
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
