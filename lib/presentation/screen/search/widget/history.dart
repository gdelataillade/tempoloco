import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/utils/helper.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  // TODO: Fix uncaught exception - bad state element
  List<Track> buildHistoryTracks(TabViewState state) {
    final List<String> historyIds = state.user.history;

    List<Track> tracks = [];

    for (int i = 0; i < historyIds.length; i++) {
      tracks.add(state.library.firstWhere((t) => t.id == historyIds[i]));
    }
    return tracks;
  }

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          Text(
            "History",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Obx(() {
            final List<Track> history = buildHistoryTracks(state);

            if (history.isEmpty) {
              return const Center(child: Text("No history"));
            }

            return Expanded(
              child: BottomShaderMask(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return TrackCard(
                      title: item.name!,
                      artist: item.artists!.first.name!,
                      imgUrl: Helper.getMinResImage(item.album!.images!),
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
