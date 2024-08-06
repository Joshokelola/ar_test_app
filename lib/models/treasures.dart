class Treasure {
  final String id;
  final String name;
  final String description;
  final String region;
  final String
      type; // e.g., artifact, audio, historical text/quote, image, etc.
  final String imageUrl; // URL to the image
  final String modelUrl; // URL to the 3D model
  final String historicalSignificance;
  final double latitude; // For AR placement
  final double longitude; // For AR placement
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
    required this.latitude,
    required this.longitude,
    required this.clue,
  });
}
