import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

class LocationService {
  Stream<Position> getUserLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 100,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // Radius of the Earth in meters
    double dLat = radians(lat2 - lat1);
    double dLon = radians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(radians(lat1)) *
            math.cos(radians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }
  bool isWithinRadius(double lat1, double lon1, double lat2, double lon2, double radius) {
  double distance = haversineDistance(lat1, lon1, lat2, lon2);
  return distance <= radius;
}
}
