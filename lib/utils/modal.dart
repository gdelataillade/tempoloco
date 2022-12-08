import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/presentation/common/modal/purchase_track_modal.dart';

class Modal {
  static showPurchaseModal(
    BuildContext context,
    Track track,
    int price,
    Function() onPurchase,
  ) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: PurchaseTrackModal(
            track: track,
            price: price,
            onPurchase: onPurchase,
          ),
        ),
      );

  static showSimpleModal(BuildContext context, Widget modal) => showDialog(
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: modal,
        ),
      );
}
