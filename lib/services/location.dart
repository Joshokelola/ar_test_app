import 'dart:async';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

class LocationService {
  // Request location permissions if not already granted
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions denied, can't proceed
        log('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions denied forever, can't proceed
      log('Location permissions are denied forever');
      return false;
    }

    // Permissions are granted
    return true;
  }

  // Check if location permissions are granted
  Future<bool> hasPermission() async {
    LocationPermission permission = await 
    Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse || 
    permission == LocationPermission.always;
  }

  Stream<Position> getUserLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
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

  bool isWithinRadius(
      double lat1, double lon1, double lat2, double lon2, double radius) {
    double distance = haversineDistance(lat1, lon1, lat2, lon2);
    return distance <= radius;
  }

  Future<Position> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      log('Error fetching current position: $e');
      rethrow;
    }
  }
}
