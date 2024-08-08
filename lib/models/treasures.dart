import 'package:vector_math/vector_math_64.dart';

class Treasure {
  final String id;
  final String name;
  final String description;
  final String region;
  final String type; // e.g., artifact, audio, historical text/quote, image, etc.
  final String imageUrl; // URL to the image
  final String modelUrl; // URL to the 3D model
  final String historicalSignificance;
  final String rarity;
  double? latitude; // Latitude of the treasure
  double? longitude; // Longitude of the treasure
  final Vector3 position; // For AR placement
  final String clue; // Clue for finding the treasure

  Treasure({
    required this.id,
    required this.name,
    required this.description,
    required this.region,
    required this.type,
    required this.imageUrl,
    required this.modelUrl,
    required this.historicalSignificance,
    required this.rarity,
    this.latitude,
    this.longitude,
    required this.position,
    required this.clue,
  });
}