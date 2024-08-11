import 'dart:async';

import 'package:flutter/material.dart';

import '../ar_test_page.dart';

class SearchingForTreasurePage extends StatefulWidget {
  const SearchingForTreasurePage({super.key});

  @override
  State<SearchingForTreasurePage> createState() =>
      _SearchingForTreasurePageState();
}

class _SearchingForTreasurePageState extends State<SearchingForTreasurePage> {
  bool _showActionButton = false; // Flag to control FAB visibility

  @override
  void initState() {
    super.initState();
    //TODO: check if user actually moved.
    // Start a timer that will set _showActionButton to true after 30 seconds
    Timer(const Duration(seconds: 30), () {
      setState(() {
        _showActionButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(!_showActionButton
                      ? 'assets/searching.png'
                      : 'assets/found_treasure.png'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !_showActionButton,
            child: const Column(
              children: [
                Text('Take your phone and move around!'),
                Text('Treasure is nearby!'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Searching...'),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(
                        //  value: 0.8,
                        ),
                  ],
                ),
              ],
            ),
          ),
          _showActionButton
              ? const Text(
                  'You seem to have found the location of the treasure.')
              : Container(),
          // Conditionally display FloatingActionButton based on _showActionButton
        ],
      ),
      floatingActionButton: Visibility(
        visible: _showActionButton,
        child: FloatingActionButton.extended(
          label: const Text('Find in AR'),
          onPressed: () {
            // Handle FAB click action here (e.g., show a success message)
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ArTestPage();
            }));
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Treasure found!')),
            // );
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
