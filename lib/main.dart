import 'package:ar_test/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/credits.dart';
import 'views/onboarding.dart';
import 'views/profile.dart';
import 'views/settings.dart';
import 'views/tutorial/leaderboard.dart';
import 'views/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heritage Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
        useMaterial3: true,
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
