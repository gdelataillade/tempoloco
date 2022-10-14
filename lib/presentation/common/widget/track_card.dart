import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class TrackCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imgUrl;
  final String trackId;
  final bool isPurchased;
  final int? price;
  final Function() onPress;
  final Function() onLike;

  const TrackCard({
    Key? key,
    required this.title,
    required this.artist,
    required this.imgUrl,
    required this.trackId,
    required this.isPurchased,
    this.price,
    required this.onPress,
    required this.onLike,
  })  : assert(isPurchased || price != null,
            "[TrackCard] if not purchased, track has to have a price"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: ktempoDark);
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
                child: Image.network(imgUrl, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: titleStyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Obx(
                () {
                  final isLiked = state.isFavorite(trackId);
                  return isPurchased
                      ? IconButton(
                          onPressed: onLike,
                          icon: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: Colors.red,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              "$price",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: ktempoDark),
                            ),
                            const Icon(
                              Icons.star_rounded,
                              color: ktempoYellow,
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
