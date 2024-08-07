import 'package:ar_test/utils/constants.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Leaderboard'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: const <Widget>[
              Text(
                'Top Players',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/m1.png'),
                ),
                title: Text('Michael William'),
                subtitle: Text('Score: 12560'),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/a1.png'),
                ),
                title: Text('Jane Doe'),
                subtitle: Text('Score: 11890'),
              ),
              // Add more ListTile widgets for other players
            ],
          ),
        ),
      ),
    );
  }
}
