import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/search/widget/search_bar.dart';
import 'package:tempoloco/presentation/screen/search/widget/tab_bar.dart';

// TODO: Hide keyboard when scroll detected
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
            "Search",
            style: Theme.of(context).textTheme.headline3,
          ),
          const SearchBar(),
          const Expanded(child: SearchResultsTabBar()),
        ],
      ),
    );
  }
}
