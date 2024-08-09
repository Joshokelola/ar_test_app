import 'package:flutter/material.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({super.key});

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Credits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Heritage Hunt Team',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildContributor('Otonye Robinson', 'Team Lead/Mobile Developer'),
            _buildContributor('Joshua Smith', 'Mobile Developer'),
            _buildContributor('Peggy A. Roxy', 'Mobile Developer'),
            _buildContributor('Philip O.', 'Mobile Developer'),
            const SizedBox(height: 20),
            const Text(
              'Special Thanks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We would like to thank everyone who supported us in making this game.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributor(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            role,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
