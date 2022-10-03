import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/screen/search/widget/search_bar.dart';
import 'package:tempoloco/presentation/screen/search/widget/tab_bar.dart';
import 'package:tempoloco/theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: ktempoPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Search"),
          SearchBar(),
          Expanded(child: SearchTabBar()),
        ],
      ),
    );
  }
}
