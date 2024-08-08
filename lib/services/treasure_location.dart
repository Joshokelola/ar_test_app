import 'dart:math';

import 'package:heritage_quest/database.dart';
import 'package:heritage_quest/models/treasures.dart';

class HideTreasure{
  // Generates the random point within a circle of a given radius around a center
  Map<String, double> getRandomPosition(double centerLat, double centerLon, double maxDistance, String rarity) {
    final random = Random();
    double distance;

    // Define distance range based on rarity
    switch (rarity) {
      case 'common':
        distance = random.nextDouble() * 10 + 10; // 10-20 meters
        break;
      case 'rare':
        distance = random.nextDouble() * 10 + 20; // 20-30 meters
        break;
      case 'very rare':
        distance = random.nextDouble() * 10 + 30; // 20-40 meters
        break;
      default:
        distance = random.nextDouble() * 10 + 10; // Default to common distance
        break;
    }

    // Random angle in radians
    double angle = random.nextDouble() * 2 * pi;
    // Calculate new latitude and longitude
    double latOffset = distance * cos(angle) / 111320; // Rough conversion to degrees
    double lonOffset = distance * sin(angle) / (111320 * cos(centerLat * pi / 180)); // Adjust for latitude

    double newLat = centerLat + latOffset;
    double newLon = centerLon + lonOffset;

    return {'latitude': newLat, 'longitude': newLon};
  }


  void placeArtifacts(double playerLat, double playerLon) {
    List<Treasure> artifacts = huntTreasures;
    for (var artifact in artifacts) {
      Map<String, double> position = getRandomPosition(
          playerLat,
          playerLon,
          30, // Maximum distance to consider
          artifact.rarity
      );
      artifact.latitude = position['latitude'];
      artifact.longitude = position['longitude'];
    }
  }


}