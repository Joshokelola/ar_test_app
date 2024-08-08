import 'dart:ui';

import 'package:heritage_quest/ar_test_page.dart';
import 'package:heritage_quest/models/treasures.dart';
import 'package:heritage_quest/utils/constants.dart';
import 'package:heritage_quest/views/profile.dart';
import 'package:heritage_quest/models/treasures.dart';
import 'package:heritage_quest/services/location.dart';
import 'package:heritage_quest/services/treasure_location.dart';
import 'package:heritage_quest/views/searching_page.dart';
import 'package:heritage_quest/views/test_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heritage_quest/views/auth/login.dart';
import 'package:heritage_quest/views/leaderboard.dart';
import 'package:heritage_quest/views/game_play.dart';
import 'package:heritage_quest/views/inventory.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '..at_test_page.dart';
import 'game_play.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  final LocationService locationService = LocationService();
  final HideTreasure treasureHider = HideTreasure();
  late GameData _gameData;
  late User _user;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _initializeGameData();
  }

  Future<void> _initializeGameData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _gameData = GameData(prefs);

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirect to login if not authenticated
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

    _user = user;

    // Fetch current location and update treasures
    Position currentLocation = await locationService.getCurrentPosition();
    List<Treasure> treasures = treasureHider.placeArtifacts(
        currentLocation.latitude, currentLocation.longitude);
    _gameData.saveTreasures(treasures);

    // Fetch user data from Firestore
    await _fetchUserData(user.uid);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchUserData(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      // You can process the user data here
      // Example: _userPoints = data['points'] ?? 0;
    } else {
      // Handle the case where user data does not exist
      print('User data does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/maps background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white54, Colors.white70],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            AssetImage('assets/avatar.jpg'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LeaderboardPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: colorPrimary,
                            ),
                            child: const Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14,
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '12560',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Let’s play &\nDiscover Nigeria',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameOptionCard('Start Hunt', 'assets/treasure.png', const ArTestPage()),
                            GameOptionCard('View Map', 'assets/adventure_icon.png', TreasureMap()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameOptionCard('Artefacts', 'assets/Diamond lime.png', const InventoryPage()),
                            GameOptionCard('Quests', 'assets/daily.png', const ArTestPage()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GameOptionCard extends StatelessWidget {
  final String title;
  final String icon;
  final Widget page;

  GameOptionCard(this.title, this.icon, this.page);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyBG),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0.7, 0.5), blurRadius: 1)
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 36, width: 36),
            const SizedBox(height: 12),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}