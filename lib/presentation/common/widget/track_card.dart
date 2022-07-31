import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class TrackCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imgUrl;
  final String trackId;
  final Function() onPress;
  final Function() onLike;

  const TrackCard({
    Key? key,
    required this.title,
    required this.artist,
    required this.imgUrl,
    required this.trackId,
    required this.onPress,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: ktempoDark);
    final state = Get.find<TabViewState>();

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onPress();
      },
      child: Container(
        height: 65,
        margin: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          color: ktempoWhite,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: const BoxDecoration(
                color: ktempoDark,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(imgUrl, width: 65, height: 65),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    Helper.formatTrackTitle(title),
                    maxLines: 1,
                    style: textStyle,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ],
            ),
            Obx(
              () {
                final isLiked = state.isFavorite(trackId);
                return IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    onLike();
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
