import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/widget/artist_item.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';

class HomeArtists extends StatelessWidget {
  const HomeArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.artists.isEmpty) {
        return const Loading(debugLabel: 'Home Artists');
      }
      return SizedBox(
        height: 120,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: state.artists.length,
          itemBuilder: (context, index) {
            final artist = state.artists[index];
            return HomeArtistItem(
              name: artist.name!,
              imgUrl: artist.images![1].url!,
            );
          },
        ),
      );
    });
  }
}
