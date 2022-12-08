import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/theme.dart';

class PurchaseTrackModal extends StatelessWidget {
  final Track track;
  final int price;
  final void Function() onPurchase;

  const PurchaseTrackModal({
    Key? key,
    required this.track,
    required this.price,
    required this.onPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();
    final enoughStars = userCtrl.enoughStars(price);
    final size = MediaQuery.of(context).size.height / 4;

    return AlertDialog(
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: ktempoPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
      content: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        height: size,
        width: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              track.name!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price: $price", // TODO: Translate
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 27),
                ),
                const Icon(Icons.star_rounded, color: ktempoYellow, size: 30),
              ],
            ),
            MainButton(
              onTap: () {
                if (enoughStars) {
                  onPurchase();
                  Get.back();
                } else {
                  HapticFeedback.heavyImpact();
                }
              },
              label: 'purchase'.tr,
              disable: !enoughStars,
            ),
          ],
        ),
      ),
    );
  }
}
