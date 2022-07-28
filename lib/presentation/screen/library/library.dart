import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<TabViewState>();

    return Obx(() {
      if (state.library.isEmpty) return const Loading();
      return ListView.builder(
        itemCount: state.library.length,
        itemBuilder: (context, index) {
          return Text(state.library[index].name!);
        },
      );
    });
  }
}
