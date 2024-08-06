import 'package:ar_test/utils/constants.dart';
import 'package:ar_test/views/game_play.dart';
import 'package:flutter/material.dart';

import '../views/onboarding.dart';
import '../views/profile.dart';


class AppBottomBarItem {
  final IconData icon;
  final String label;

  AppBottomBarItem({required this.icon, required this.label});
}

class AppBottBar extends StatefulWidget {
  const AppBottBar({super.key});

  @override
  _AppBottBarState createState() => _AppBottBarState();
}

class _AppBottBarState extends State<AppBottBar> {
  int _selectedIndex = 0;

  final List<AppBottomBarItem> _barItems = [
    AppBottomBarItem(icon: Icons.home, label: 'Home'),
    AppBottomBarItem(icon: Icons.explore, label: 'Explore'),
    AppBottomBarItem(icon: Icons.turned_in_not, label: 'Tag'),
    AppBottomBarItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  final List<Widget> _pages = [
    const ArenaSelect(),
    const OnboardingScreen(), //dummy page
    const ProfilePage(), //dummy duplicate page
    const ProfilePage(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_barItems.length, (index) {
            final currentBarItem = _barItems[index];
            final isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () => _onItemSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected ? colorPrimary : Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      currentBarItem.icon,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 5),
                      Text(
                        currentBarItem.label,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}