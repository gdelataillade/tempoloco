import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/artist_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class SearchResultsArtist extends StatelessWidget {
  const SearchResultsArtist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();
    return Obx(() {
      if (state.artistResults.isEmpty) {
        return const Center(child: Text("No results"));
      }
      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.artistResults.length,
          itemBuilder: (context, index) {
            final artist = state.artistResults[index];
            return Column(
              children: [
                ArtistCard(
                  name: artist.name!,
                  imgUrl: artist.images!.first.url!,
                ),
                if (index == state.artistResults.length - 1)
                  const Center(child: Text("Loading...")),
              ],
            );
          },
        ),
      );
    });
  }
}
