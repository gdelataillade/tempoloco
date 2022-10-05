import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class PurchaseTrackModal extends StatelessWidget {
  final Track track;
  final int price;

  const PurchaseTrackModal({Key? key, required this.track, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

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
              onPressed: () {},
              child: const Text("Close"),
            ),
            RawMaterialButton(
              onPressed: () {
                state.purchaseTrack(
                  track.id!,
                  track.artists!.first.id!,
                  price,
                );
                Get.back();
              },
              child: const Text("Purchase"),
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
            Text("$price"),
          ],
        ),
      ),
    );
  }
}