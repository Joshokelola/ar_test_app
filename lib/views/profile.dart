import 'package:flutter/material.dart';

import 'home_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/m1.png'), // Add your profile image asset
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Michael William',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Expert',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Total Score',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '12560',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.white,
                      ),
                      const Column(
                        children: [
                          Text(
                            'Collection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '53',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Level',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width * 0.68, // 68% of the width
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('68'),
                    Text('100'),
                  ],
                ),
                const SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Games',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GameHome()),
                        );
                      },
                      child: 
                    const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/m1.png'), // Add your game image asset
                  ),
                  title: Text('Fifa Online'),
                  subtitle: Text('15 Oct 2021'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.group),
                      SizedBox(width: 5),
                      Text('4'),
                    ],
                  ),
                ),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/a1.png'), // Add your game image asset
                  ),
                  title: Text('Archery Battle'),
                  subtitle: Text('9 Oct 2021'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.group),
                      SizedBox(width: 5),
                      Text('2'),
                    ],
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