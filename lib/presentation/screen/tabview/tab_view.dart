import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/home/home.dart';
import 'package:tempoloco/presentation/screen/library/library.dart';
import 'package:tempoloco/presentation/screen/search/search.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

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
    return GetBuilder<TabViewState>(
      init: TabViewState(),
      builder: (state) => Scaffold(
        backgroundColor: ktempoPurple,
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            SearchScreen(),
            HomeScreen(),
            LibraryScreen(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomNavigationBar(
            iconSize: 30,
            selectedColor: ktempoYellow,
            strokeColor: ktempoYellow,
            unSelectedColor: ktempoWhite,
            backgroundColor: ktempoPurple,
            scaleCurve: Curves.easeInOut,
            currentIndex: selectedIndex,
            isFloating: true,
            borderRadius: const Radius.circular(15),
            onTap: (index) {
              HapticFeedback.selectionClick();
              setState(() {
                tabController.animateTo(index);
                selectedIndex = index;
              });
            },
            items: [
              CustomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.search,
                  size: selectedIndex == 0 ? 32 : 28,
                ),
              ),
              CustomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.home,
                  size: selectedIndex == 1 ? 32 : 28,
                ),
              ),
              CustomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.music,
                  size: selectedIndex == 2 ? 32 : 28,
                ),
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
