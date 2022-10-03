import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view_state.dart';
import 'package:tempoloco/theme.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final state = Get.find<TabViewState>();

  Timer? debounce;

  late TextEditingController controller;

  void onType() {
    final input = controller.text.trim();

    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      state.searchParams.input = input;
      if (input.length > 2) state.search(input, clear: true);
      if (input.isEmpty) state.trackResults.clear();
    });
  }

  @override
  void initState() {
    controller = TextEditingController(text: state.searchParams.input);
    controller.addListener(onType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: TextField(
        autocorrect: false,
        controller: controller,
        cursorColor: ktempoPink,
        style: const TextStyle(color: ktempoDark),
        decoration: InputDecoration(
          prefixIcon: const Icon(FeatherIcons.search, color: ktempoDark),
          hintText: 'Search for song or artist...',
          hintStyle: TextStyle(color: ktempoDark.withOpacity(0.8)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }
}
