import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/search/widget/search_bar.dart';
import 'package:tempoloco/presentation/screen/search/widget/tab_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'search'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SearchBar(),
          const Expanded(child: SearchResultsTabBar()),
        ],
      ),
    );
  }
}
