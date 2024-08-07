import 'dart:async';
import 'package:ar_test/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late StreamSubscription<Position> _positionStream;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  Future<void> _startLocationUpdates() async {
    //   var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   return Future.error('Location services are disabled.');
    // }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 100,
    );

    try {
      _positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        setState(() {
          _currentPosition = position;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var locationService = LocationService();
    var withinRad = '';
    if (_currentPosition != null) {
      var playerLat = _currentPosition?.latitude;
      var playerLng = _currentPosition?.longitude;
      // debugPrint(playerLng!.toString());
      var treasureLat = 6.6771571;
      var treasureLng = 3.361587;

      var distance = Geolocator.distanceBetween(
          playerLat!, playerLng!, treasureLat, treasureLng);
      debugPrint('Distance - $distance');
      setState(() {
        withinRad = distance.toString();
      });
      // debugPrint(isTreasureNear.toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: StreamBuilder<Position>(
          stream: Geolocator.getPositionStream(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Latitude: ${_currentPosition?.latitude ?? 'Loading...'}'),
                  Text(
                      'Longitude: ${_currentPosition?.longitude ?? 'Loading...'}'),
                  Text(withinRad.toString()),
                ],
              ),
            );
          }),
    );
  }
}
