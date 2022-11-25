import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/search/widget/history.dart';
import 'package:tempoloco/presentation/screen/search/widget/results_artist.dart';
import 'package:tempoloco/presentation/screen/search/widget/results_track.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class SearchResultsTabBar extends StatefulWidget {
  const SearchResultsTabBar({Key? key}) : super(key: key);

  @override
  State<SearchResultsTabBar> createState() => _SearchResultsTabBarState();
}

class _SearchResultsTabBarState extends State<SearchResultsTabBar>
    with SingleTickerProviderStateMixin {
  final state = Get.find<TabViewState>();
  int selectedIndex = 0;
  late TabController tabController;

  void onSwipe() {
    if (tabController.index != selectedIndex) {
      setState(() => selectedIndex = tabController.index);

      final params = state.searchParams;
      params.type = selectedIndex == 0 ? SearchType.tracks : SearchType.artists;
      if (params.input.isNotEmpty &&
          params.input != params.lastInputOnOtherTab) {
        state.search(params.input, clear: true);
      }
      params.lastInputOnOtherTab = params.input;
    }
  }

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(onSwipe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(() => state.trackResults.isEmpty
          ? const History()
          : Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: SizedBox(
                  height: 30,
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
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: selectedIndex == 0
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                  ),
                        ),
                        Text(
                          'artists'.tr,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: selectedIndex == 1
                                        ? FontWeight.w700
                                        : FontWeight.w400,
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
                  SearchResultsTrack(),
                  SearchResultsArtist(),
                ],
              ),
            )),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
