import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/widget/artists.dart';
import 'package:tempoloco/presentation/screen/home/widget/quick_play.dart';
import 'package:tempoloco/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Tempoloco',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: ktempoYellow,
                ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              'artists'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        const HomeArtists(),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Text(
              'quickPlay'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        const HomeQuickPlay(),
      ],
    );
  }
}
