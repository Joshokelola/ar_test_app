import 'package:heritage_quest/views/home_screen.dart';
import 'package:flutter/material.dart';
import '../../models/tutorial.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Tutorial'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: tutorialSteps.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(tutorialSteps[index].imagePath),
                const SizedBox(height: 20),
                Text(
                  tutorialSteps[index].title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  tutorialSteps[index].description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index > 0)
                      TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('Previous'),
                      ),
                    if (index < tutorialSteps.length - 1)
                      TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('Next'),
                      ),
                    if (index == tutorialSteps.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const GameHome(), // Replace with your page
                            ),
                          );
                        },
                        child: const Text('Enter Game'),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
