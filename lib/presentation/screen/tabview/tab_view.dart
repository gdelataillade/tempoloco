import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/avatar_card.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/home/home.dart';
import 'package:tempoloco/presentation/screen/library/library.dart';
import 'package:tempoloco/presentation/screen/search/search.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/utils/helper.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  int selectedIndex = 1;

  @override
  void initState() {
    tabController =
        TabController(length: 3, vsync: this, initialIndex: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<TabViewState>(
      init: TabViewState(),
      builder: (state) => !state.isLoaded.value
          ? const Scaffold(body: Loading(debugLabel: 'Tab View'))
          : Scaffold(
              backgroundColor: ktempoPurple,
              appBar: AppBar(
                leading: IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(FeatherIcons.settings, size: 30),
                  onPressed: () {
                    Helper.hapticFeedback();
                    Get.toNamed('/settings');
                  },
                ),
                actions: [
                  Center(
                    child: Text(
                      state.user.nbStars.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Icon(Icons.star_rounded, color: ktempoYellow, size: 30),
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.emoji_events_outlined, size: 30),
                    onPressed: () {
                      Helper.hapticFeedback();
                      Get.toNamed(
                        '/achievements',
                        arguments: state.library,
                      );
                    },
                  ),
                  state.isLoaded.value
                      ? GestureDetector(
                          onTap: () {
                            Helper.hapticFeedback();
                            Get.toNamed('/profile', arguments: state.svgRoot);
                          },
                          child: Hero(
                            tag: 'avatar',
                            child: AvatarCard(size: 28, svgRoot: state.svgRoot),
                          ),
                        )
                      : const Icon(FeatherIcons.user, size: 30),
                  const SizedBox(width: 8),
                ],
              ),
              body: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SearchScreen(),
                  HomeScreen(),
                  LibraryScreen(),
                ],
              ),
              bottomNavigationBar: SizedBox(
                height: 80,
                child: CustomNavigationBar(
                  iconSize: 30,
                  elevation: 1,
                  opacity: 0.1,
                  selectedColor: ktempoYellow,
                  strokeColor: ktempoYellow,
                  unSelectedColor: ktempoWhite,
                  backgroundColor: ktempoPurple,
                  scaleCurve: Curves.easeInOut,
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    Helper.hapticFeedback();
                    setState(() {
                      tabController.animateTo(index);
                      selectedIndex = index;
                    });
                  },
                  items: [
                    CustomNavigationBarItem(
                      icon: const Icon(FeatherIcons.search),
                    ),
                    CustomNavigationBarItem(
                      icon: const Icon(FeatherIcons.home),
                    ),
                    CustomNavigationBarItem(
                      icon: const Icon(FeatherIcons.music),
                    ),
                  ],
                ),
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
