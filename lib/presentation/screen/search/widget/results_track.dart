import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/common/widget/track_card.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';
import 'package:tempoloco/utils/modal.dart';

class SearchResultsTrack extends StatefulWidget {
  const SearchResultsTrack({Key? key}) : super(key: key);

  @override
  State<SearchResultsTrack> createState() => _SearchResultsTrackState();
}

class _SearchResultsTrackState extends State<SearchResultsTrack> {
  final controller = ScrollController();
  final state = Get.find<TabViewState>();

  void detectEnd() {
    if (controller.position.atEdge) {
      if (controller.position.pixels != 0) {
        state.searchParams.tracksPage += 1;
        state.search(state.searchParams.input);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(detectEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (state.library.isEmpty || state.trackResults.isEmpty) {
        return const Center(child: Text("No results"));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BottomShaderMask(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.trackResults.length,
            controller: controller,
            itemBuilder: (context, index) {
              final item = state.trackResults[index];
              final isPurchased = state.isPurchased(item.id!);
              final price = Helper.getPrice(item.popularity!);
              return Column(
                children: [
                  TrackCard(
                    title: item.name!,
                    artist: item.artists!.first.name!,
                    imgUrl: Helper.getMinResImage(item.album!.images!),
                    trackId: item.id!,
                    isPurchased: isPurchased,
                    price: price,
                    onPress: () {
                      if (isPurchased) {
                        state.addTrackToHistory(item.id!);
                        Get.toNamed('/game', arguments: item);
                      } else {
                        Modal.showDialogModal(context, item, price);
                      }
                    },
                    onLike: () => state.likeTrack(item.id!),
                  ),
                  if (index == state.trackResults.length - 1)
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Obx(
                        () => state.noMoreResults.value
                            ? const Text('No more results')
                            : const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(ktempoWhite),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
