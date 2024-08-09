import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Quests'),
              onTap: () {
                Navigator.pushNamed(context, '/quests');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Credits'),
              onTap: () {
                Navigator.pushNamed(context, '/credits');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg2.jfif',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [ Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Welcome to HeritageHunt Game',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu),
                          color: Colors.green,
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildButton(context, 'Start Hunt', '/startHunt'),
                          const SizedBox(height: 20),
                          _buildButton(context, 'Profile', '/profile'),
                          const SizedBox(height: 20),
                          _buildButton(context, 'Leaderboard', '/leaderboard'),
                          const SizedBox(height: 20),
                          _buildButton(context, 'Settings', '/settings'),
                          const SizedBox(height: 20),
                          _buildButton(context, 'About', '/about'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}