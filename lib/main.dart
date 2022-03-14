import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tempoloco/presentation/funnel/splash_screen.dart';
import 'package:tempoloco/presentation/theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tempoloco',
      initialRoute: '/onboarding',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: [
        GetPage(
          name: '/splashscreen',
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/onboarding',
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
