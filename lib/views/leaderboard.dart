import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaderboardService leaderboardService = LeaderboardService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Leaderboard', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: leaderboardService.fetchLeaderboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              final leaderboard = snapshot.data!;

              return ListView.builder(
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  final user = leaderboard[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(
                          'assets/default_avatar.png'), // Placeholder for user avatars
                    ),
                    title: Text(user['name'] ?? 'Unknown'),
                    subtitle: Text('Score: ${user['points']}'),
                    trailing: Text('#${index + 1}'),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
