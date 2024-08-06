import 'dart:async';

import 'package:ar_test/views/onboarding.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: const Center(
        child: Image(
          image: AssetImage('assets/a1.png'),
        ),
      ),
    );
  }
}