import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/treasures.dart';
import '../shared_preferences.dart';
import '../services/location.dart';

class TreasureMap extends StatefulWidget {
  const TreasureMap({super.key});

  @override
  State<TreasureMap> createState() => _TreasureMapState();
}

class _TreasureMapState extends State<TreasureMap> {
  late GameData _gameData;
  final LocationService _locationService = LocationService();
  late GoogleMapController _mapController;

  LatLng _userLocation = const LatLng(0.0, 0.0);
  final Set<Marker> _markers = {};
  List<Treasure> _treasuresList = [];
  BitmapDescriptor? _userMarkerIcon;
  BitmapDescriptor? _treasureMarkerIcon;

  @override
  void initState() {
    super.initState();
    _initializeGameData();
    _getUserLocation();
    _loadMarkerIcons();
  }

  Future<void> _initializeGameData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _gameData = GameData(prefs);
    _treasuresList = await _gameData.getTreasureList();
    _addTreasureMarkers(); // Add treasure markers after loading treasures
  }

  Future<void> _getUserLocation() async {
    try {
      final currentLocation = await _locationService.getCurrentPosition();
      setState(() {
        _userLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        _markers.clear(); // Clear markers before adding new ones
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: _userLocation,
            icon: _userMarkerIcon ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue), // User location marker
          ),
        );
      });
      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_userLocation, 12),
        );
      }
    } catch (e) {
      // Handle the exception (e.g., location permission not granted)
      log('Error getting location: $e');
    }
  }

  void _addTreasureMarkers() {
    for (var treasure in _treasuresList) {
      final location = LatLng(treasure.latitude!, treasure.longitude!);
      _markers.add(
        Marker(
          markerId: MarkerId('treasure_${treasure.id}'),
          position: location,
          icon: _treasureMarkerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet), // Treasure marker
        ),
      );
    }
    setState(() {}); // Trigger a rebuild to update the markers on the map
  }

  Future<void> _loadMarkerIcons() async {
    _userMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
      'assets/playericon.png',
    );
    _treasureMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
      'assets/Diamond lime.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treasure Map')),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          // You might want to move this line into _getUserLocation()
          // to avoid animating the camera before the location is fetched
        },
        initialCameraPosition: CameraPosition(
          target: _userLocation,
          zoom: 12.0,
        ),
        markers: _markers,
      ),
    );
  }
}
