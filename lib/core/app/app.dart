import 'package:flutter/material.dart';

import '../../views/credits.dart';
import '../../views/onboarding.dart';
import '../../views/profile.dart';
import '../../views/settings.dart';
import '../../views/splash.dart';
import '../../views/tutorial/leaderboard.dart';
import '../../views/welcome.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heritage Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
      ),
      initialRoute: 'splashscreen',
      routes: {
        'splashscreen': (context) => const Splashscreen(),
        'onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/leaderboard': (context) => const Leaderboard(),
        '/settings': (context) => const SettingsPage(),
        '/credits': (context) => const CreditsPage(),
      },
    );
  }
}
