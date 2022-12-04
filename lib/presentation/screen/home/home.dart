import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/widget/artists.dart';
import 'package:tempoloco/presentation/screen/home/widget/quick_play.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Tempoloco',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child:
              Text('artists'.tr, style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeArtists(),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Text('quickPlay'.tr,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const HomeQuickPlay(),
      ],
    );
  }
}
