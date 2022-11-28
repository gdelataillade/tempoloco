import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/artist_card.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/utils/helper.dart';

class SearchResultsArtist extends StatelessWidget {
  const SearchResultsArtist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();
    return Obx(() {
      if (state.artistResults.isEmpty) {
        return Center(child: Text('noResults'.tr));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.artistResults.length,
            itemBuilder: (context, index) {
              final artist = state.artistResults[index];
              return ArtistCard(
                id: artist.id!,
                name: artist.name!,
                imgUrl: Helper.getLowResImage(artist.images!),
                onTap: () => Get.toNamed('artist', arguments: artist),
              );
            },
          ),
        ),
      );
    });
  }
}
