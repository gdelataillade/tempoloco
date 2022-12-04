import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/library/widget/artists.dart';
import 'package:tempoloco/presentation/screen/library/widget/favorite.dart';
import 'package:tempoloco/presentation/screen/library/widget/tracks.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  static int selectedIndex = 0;
  late TabController tabController;

  void onSwipe() {
    if (tabController.index != selectedIndex) {
      setState(() => selectedIndex = tabController.index);
    }
  }

  @override
  void initState() {
    tabController =
        TabController(initialIndex: selectedIndex, vsync: this, length: 3);
    tabController.addListener(onSwipe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SizedBox(
            height: 40,
            child: AppBar(
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                indicatorWeight: 1,
                controller: tabController,
                indicatorColor: ktempoPurple,
                onTap: (index) {
                  Helper.hapticFeedback();
                  setState(() => selectedIndex = index);
                },
                tabs: [
                  Text(
                    'songs'.tr,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: selectedIndex == 0
                              ? FontWeight.w700
                              : FontWeight.w200,
                          fontSize: selectedIndex == 0 ? 23 : 20,
                        ),
                  ),
                  Text(
                    'artists'.tr,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: selectedIndex == 1
                              ? FontWeight.w700
                              : FontWeight.w200,
                          fontSize: selectedIndex == 1 ? 23 : 20,
                        ),
                  ),
                  Text(
                    'favorite'.tr,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: selectedIndex == 2
                              ? FontWeight.w700
                              : FontWeight.w200,
                          fontSize: selectedIndex == 2 ? 23 : 20,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            LibraryTracks(),
            LibraryArtists(),
            LibraryFavorite(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
