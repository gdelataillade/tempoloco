import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ktempoPurple,
      child: const Center(child: Text('Home')),
    );
  }
}
