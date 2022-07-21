import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/common/widget/loading.dart';
import 'package:tempoloco/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    timer =
        Timer(const Duration(seconds: 1), () => Get.offAllNamed('/onboarding'));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ktempoPurple,
      body: Loading(),
    );
  }
}
