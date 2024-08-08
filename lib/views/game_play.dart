import 'package:heritage_quest/ar_test_page.dart';
import 'package:flutter/material.dart';

class ArenaSelect extends StatefulWidget {
  const ArenaSelect({super.key});

  @override
  State<ArenaSelect> createState() => _ArenaSelectState();
}

class _ArenaSelectState extends State<ArenaSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Welcome to Game Arena',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
              'Choose your play arena',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1524835005923-56700046e4a8?fit=crop&w=1052&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'North Central',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/20452526/pexels-photo-20452526/free-photo-of-men-during-dambe-competition.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'North West (Hausa)',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
            // Additional content area
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/18772923/pexels-photo-18772923/free-photo-of-students-of-al-amin-islamic-college-arriving-at-the-emirs-palace.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'North East (Fulani)',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/22674728/pexels-photo-22674728/free-photo-of-the-national-theatre-nigeria.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'South West (Yoruba)',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/27291194/pexels-photo-27291194/free-photo-of-a-group-of-people-in-african-costumes-dancing.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'South East (Igbo)',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pinimg.com/originals/1d/82/04/1d8204482c819e7694e2ab960fcae3b6.jpg',),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'South South (Ijaw)',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArTestPage()),
                        );
                      },
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}
