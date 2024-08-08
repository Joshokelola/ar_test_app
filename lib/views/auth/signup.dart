import 'package:heritage_quest/views/auth/login.dart';
import 'package:heritage_quest/views/home_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 70),
                const Text(
                  'Start Your Hunting Adventure',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: greyBG,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: colorPrimary,
                        )),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: greyBG,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: colorPrimary,
                        )),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: greyBG,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: colorPrimary,
                        )),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: greyBG,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: colorPrimary,
                        )),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameHome()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: colorPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
