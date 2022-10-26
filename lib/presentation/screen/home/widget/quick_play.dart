import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class HomeQuickPlay extends StatelessWidget {
  const HomeQuickPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Expanded(
      child: Obx(() {
        if (state.library.isEmpty) {
          return const Loading(debugLabel: 'Quick Play');
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: state.library.length,
          itemBuilder: (context, index) {
            final item = state.library[index];
            final size = Get.size.width * 0.75;

            return GestureDetector(
              onTap: () {
                Get.toNamed('/game', arguments: item);
              },
              child: Column(
                children: [
                  Container(
                    width: size,
                    height: size,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ktempoDark,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0.2,
                          blurRadius: 2,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.network(
                        Helper.getMaxResImage(item.album!.images!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(item.name!),
                  Text(item.artists!.first.name!),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
