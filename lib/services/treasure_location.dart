import 'dart:math';

import '../shared/database.dart';
import '../models/treasures.dart';

class HideTreasure {
  // Generates a random point within a circle of a given radius around a center
  Map<String, double> getRandomPosition(double centerLat, double centerLon, double maxDistance, String rarity) {
    final random = Random();
    double distance;

    // Define distance range based on rarity
    switch (rarity) {
      case 'common':
        distance = random.nextDouble() * 5 + 5; // 5-10 meters
        break;
      case 'rare':
        distance = random.nextDouble() * 10 + 5; //
        break;
      case 'very rare':
        distance = random.nextDouble() * 10 + 10; //
        break;
      default:
        distance = random.nextDouble() * 15 + 10; // Default to common distance
        break;
    }

    // Ensure distance does not exceed maxDistance
    distance = min(distance, maxDistance);

    // Random angle in radians
    double angle = random.nextDouble() * 2 * pi;
    // Calculate new latitude and longitude
    double latOffset = distance * cos(angle) / 111320; // Rough conversion to degrees
    double lonOffset = distance * sin(angle) / (111320 * cos(centerLat * pi / 180)); // Adjust for latitude

    double newLat = centerLat + latOffset;
    double newLon = centerLon + lonOffset;

    // Ensure coordinates are within valid range
    newLat = newLat.clamp(-90.0, 90.0);
    newLon = newLon.clamp(-180.0, 180.0);

    return {'latitude': newLat, 'longitude': newLon};
  }

  // Place artifacts around the player's location
  List<Treasure> placeArtifacts(double playerLat, double playerLon) {
    List<Treasure> artifacts = huntTreasures;
    List<Treasure> updatedArtifacts = [];
    for (var artifact in artifacts) {
      Map<String, double> position = getRandomPosition(
          playerLat,
          playerLon,
          25, // Maximum distance to consider
          artifact.rarity
      );
      artifact.latitude = position['latitude'];
      artifact.longitude = position['longitude'];
      updatedArtifacts.add(artifact);
    }
    return updatedArtifacts;
  }

}
