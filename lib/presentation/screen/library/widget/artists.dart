import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';

class LibraryArtists extends StatelessWidget {
  const LibraryArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.artists.isEmpty) return const Loading();
      return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.artists.length,
          itemBuilder: (context, index) {
            final artist = state.artists[index];
            return Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(artist.images!.last.url!),
                  ),
                ),
                Text(
                  artist.name!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
