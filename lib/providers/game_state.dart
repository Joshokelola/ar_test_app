
import '../database.dart';
import '../models/treasures.dart';

class GameState {
  final int score;
  final List<Treasure> collectedArtifacts;
  final List<Treasure> availableArtifacts;
  final String currentLocation;

  GameState({
    required this.score,
    required this.collectedArtifacts,
    required this.availableArtifacts,
    required this.currentLocation,
  });

  GameState.initial()
      : score = 0,
        collectedArtifacts = [],
        availableArtifacts = huntTreasures,
        currentLocation = 'Starting Point';

  GameState copyWith({
    int? score,
    List<Treasure>? collectedArtifacts,
    List<Treasure>? availableArtifacts,
    String? currentLocation,
  }) {
    return GameState(
      score: score ?? this.score,
      collectedArtifacts: collectedArtifacts ?? this.collectedArtifacts,
      availableArtifacts: availableArtifacts ?? this.availableArtifacts,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
