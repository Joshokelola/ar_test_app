import 'package:ar_test/utils/navbar.dart';
import 'package:ar_test/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/credits.dart';
import 'views/onboarding.dart';
import 'views/profile.dart';
import 'views/settings.dart';
import 'views/tutorial/leaderboard.dart';
import 'views/tutorial/tutorial.dart';
import 'views/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heritage Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'splashscreen',
      routes: {
        'splashscreen': (context) => const Splashscreen(),
        'onboarding': (context) => const OnboardingScreen(),
        'bnav': (context) => const AppBottBar(),
        '/welcome': (context) => const WelcomeScreen(),
        '/startHunt': (context) => const TutorialScreen(),
        '/profile': (context) => const ProfilePage(),
        '/leaderboard': (context) => const Leaderboard(),
        '/settings': (context) => const SettingsPage(),
        '/credits': (context) => const CreditsPage(),
      },
    );
  }
}
