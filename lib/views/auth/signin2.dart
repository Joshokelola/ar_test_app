import 'dart:ui'; // For BackdropFilter
import 'package:heritage_quest/views/auth/Signin.dart';
import 'package:flutter/material.dart';
import 'package:heritage_quest/views/auth/login.dart';

import '../../utils/navbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/bg2.jfif', // Update this path to your background image
            fit: BoxFit.cover,
          ),
          // Blurred background with overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Optional dark overlay for better readability
            ),
          ),
          // Show the bottom sheet
          Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent, // Ensure background is transparent
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _fullnameController,
                                decoration: const InputDecoration(labelText: 'Full Name'),
                              ),
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(labelText: 'Email Address'),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(labelText: 'Password'),
                                obscureText: true,
                              ),
                              TextField(
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(labelText: 'Confirm Password'),
                                obscureText: true,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _termsAccepted,
                                    onChanged: (value) {
                                      setState(() {
                                        _termsAccepted = value!;
                                      });
                                    },
                                  ),
                                  const Text("I agree to the Terms and Conditions"),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const AppBottBar(), // Replace with your page
                                    ),
                                  );
                                },
                                child: const Text('Sign Up'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(), // Replace with your page
                                    ),
                                  );
                                },
                                child: const Text("Already have an account? Sign In Here"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Open Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
