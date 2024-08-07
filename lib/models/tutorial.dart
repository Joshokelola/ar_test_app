class TutorialStep {
  final String title;
  final String description;
  final String imagePath;

  TutorialStep({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}


final List<TutorialStep> tutorialSteps = [
  TutorialStep(
    title: 'Welcome to HeritageHunt!',
    description: 'This game will test your skills and wit as you search for hidden treasures.',
    imagePath: 'assets/a1.png',
  ),
  TutorialStep(
    title: 'How to Play',
    description: 'Navigate through the arenas and find clues to discover national treasures.',
    imagePath: 'assets/m1.png',
  ),
  TutorialStep(
    title: 'Collect Rewards',
    description: 'Earn points and rewards for every treasure you find and every puzzle you solve.',
    imagePath: 'assets/a1.png',
  ),
  TutorialStep(
    title: 'Multiplayer Game',
    description: 'Challenge your friends and see who can find the most treasures faster!',
    imagePath: 'assets/m1.png',
  ),
  TutorialStep(
    title: 'Get Started!',
    description: 'Let the adventures begin. Start your first heritage hunt now!',
    imagePath: 'assets/a1.png',
  ),
];
