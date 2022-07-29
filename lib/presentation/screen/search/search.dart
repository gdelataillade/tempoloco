import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ktempoPurple,
      child: const Center(child: Text('Search')),
    );
  }
}
