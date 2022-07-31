import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.results.isEmpty) return const Center(child: Text("No results"));
      return Container(
        color: ktempoPurple,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.results.length,
          itemBuilder: (context, index) {
            final item = state.results[index];
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
