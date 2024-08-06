import 'package:flutter/material.dart';

class GameHome extends StatelessWidget {
  const GameHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.green),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                            radius: 14,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            )),
                        SizedBox(width: 5),
                        Text('12560', style: TextStyle(fontSize: 20, color: Colors.white,)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Let’s play &\nDiscover Nigeria',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1.5,
                children: [
                  GameCategoryCard('Racing', Icons.directions_car),
                  GameCategoryCard('Puzzle', Icons.extension),
                  GameCategoryCard('Sport', Icons.sports_basketball),
                  GameCategoryCard('Strategy', Icons.king_bed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  GameCategoryCard(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white,
      child: Center(
        child: Image.asset('assets/treasure.png'),
      ),
    );
  }
}
