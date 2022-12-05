import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class TrackCard extends StatelessWidget {
  final String id;
  final String title;
  final String artist;
  final String imgUrl;
  final int? price;
  final Function() onPress;
  final Function() onLike;

  const TrackCard({
    Key? key,
    required this.id,
    required this.title,
    required this.artist,
    required this.imgUrl,
    this.price,
    required this.onPress,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: ktempoDark, fontWeight: FontWeight.w600);
    final textStyle =
        Theme.of(context).textTheme.bodySmall!.copyWith(color: ktempoDark);

    return GestureDetector(
      onTap: () {
        Helper.hapticFeedback();
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
            Hero(
              tag: id,
              child: Container(
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
                    const SizedBox(height: 3),
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
                  return userCtrl.isPurchased(id)
                      ? IconButton(
                          onPressed: onLike,
                          splashRadius: 10,
                          icon: Icon(
                            userCtrl.isFavorite(id)
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: ktempoRed,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              '$price',
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
