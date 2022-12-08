import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/widget/artists.dart';
import 'package:tempoloco/presentation/screen/home/widget/quick_play.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Improve logo
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Expanded(
          child: Column(
            children: [
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
          ),
        ),
      ],
    );
  }
}
