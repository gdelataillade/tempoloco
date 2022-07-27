import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabViewState>(
      init: TabViewState(),
      builder: (state) => Scaffold(
        body: TabBarView(
          controller: tabController,
          children: const [
            Center(child: Text("Search")),
            Center(child: Text("Home")),
            Center(child: Text("Library")),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            tabs: const [
              Icon(Icons.search),
              Icon(Icons.home),
              Icon(Icons.library_music),
            ],
          ),
        ),
      ),
    );
  }
}
