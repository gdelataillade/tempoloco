import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/loading.dart';

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
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading(debugLabel: 'Splash Screen'));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
