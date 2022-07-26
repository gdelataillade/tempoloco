import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tempoloco/presentation/funnel/onboarding/onboarding_funnel.dart';
import 'package:tempoloco/presentation/screen/home/home.dart';
import 'package:tempoloco/presentation/screen/splash_screen.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/service/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([Firebase.initializeApp(), setupLocator()]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tempoloco',
      initialRoute: '/splashscreen',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: [
        GetPage(
          name: '/splashscreen',
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingFunnel(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
