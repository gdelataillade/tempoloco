import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

// TODO: Reload list when updated
class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Container(
      color: ktempoPurple,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "History",
            style: Theme.of(context).textTheme.headline3,
          ),
          Obx(() {
            if (state.history.isEmpty) {
              return const Center(child: Text("No history"));
            }

            return Expanded(
              child: BottomShaderMask(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    final item = state.history[index];
                    return TrackCard(
                      title: item.name!,
                      artist: item.artists!.first.name!,
                      imgUrl: item.album!.images![1].url!,
                      trackId: item.id!,
                      isPurchased: true,
                      onPress: () {
                        state.addTrackToHistory(item.id!);
                        Get.toNamed('/game', arguments: item);
                      },
                      onLike: () => state.likeTrack(item.id!),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
