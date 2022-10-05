import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:tempoloco/presentation/common/modal/purchase_track.dart';

class Modal {
  static showDialogModal(BuildContext context, Track track, int price) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: PurchaseTrackModal(track: track, price: price),
        ),
      );
}
