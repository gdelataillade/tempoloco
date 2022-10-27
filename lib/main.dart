import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';

import 'package:tempoloco/presentation/funnel/onboarding/onboarding_funnel.dart';
import 'package:tempoloco/presentation/screen/achievements/achievements_screen.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen.dart';
import 'package:tempoloco/presentation/screen/game/game.dart';
import 'package:tempoloco/presentation/screen/profile/profile.dart';
import 'package:tempoloco/presentation/screen/settings/settings.dart';
import 'package:tempoloco/presentation/screen/splash_screen.dart';
import 'package:tempoloco/presentation/screen/tabview/tab_view.dart';
import 'package:tempoloco/theme.dart';
import 'package:tempoloco/service/locator.dart';
import 'package:tempoloco/utils/helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(),
    Helper.setup(),
    setupLocator(),
  ]);

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
          name: '/tabview',
          page: () => const TabView(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/settings',
          page: () => const Settings(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/profile',
          page: () => const Profile(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/achievements',
          page: () => const Achievements(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/game',
          page: () => const Game(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/artist',
          page: () => const ArtistScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
