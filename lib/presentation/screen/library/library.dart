import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempoloco/presentation/screen/library/widget/favorite.dart';
import 'package:tempoloco/presentation/screen/library/widget/tracks.dart';
import 'package:tempoloco/theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController tabController;

  void onSwipe() {
    if (tabController.index != selectedIndex) {
      setState(() => selectedIndex = tabController.index);
    }
  }

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(onSwipe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ktempoPurple,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              indicatorWeight: 1,
              controller: tabController,
              indicatorColor: ktempoPurple,
              onTap: (index) {
                HapticFeedback.selectionClick();
                setState(() => selectedIndex = index);
              },
              tabs: [
                Text(
                  "Songs",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: selectedIndex == 0
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                ),
                Text(
                  "Artists",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: selectedIndex == 1
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                ),
                Text(
                  "Favorite",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: selectedIndex == 2
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            LibraryTracks(),
            Center(child: Text("Artists")),
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
