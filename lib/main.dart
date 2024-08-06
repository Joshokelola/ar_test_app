import 'package:ar_test/views/splash.dart';
import 'package:flutter/material.dart';

import 'ar_test_page.dart';
import 'presentation/home_screen.dart';

void main() {
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
        useMaterial3: true,
      ),
      home: const GameHome(),
      home: const Splashscreen(),
    );
  }
}

