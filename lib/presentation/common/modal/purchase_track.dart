import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/intl.dart';

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

    return AlertDialog(
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: ktempoDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RawMaterialButton(
              onPressed: Get.back,
              child: Text(Str.close),
            ),
            RawMaterialButton(
              onPressed: () {
                if (enoughStars) {
                  onPurchase();
                  Get.back();
                }
              },
              child: Text(
                Str.purchase,
                style: TextStyle(
                  color: enoughStars ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(track.name!),
            Text(price.toString()),
          ],
        ),
      ),
    );
  }
}
