import 'dart:async';
import 'dart:math';
import 'package:ar_test/database.dart';
import 'package:ar_test/models/treasures.dart';
import 'package:ar_test/services/treasure_location.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArTestPage extends StatefulWidget {
  const ArTestPage({super.key});

  @override
  ArTestPageState createState() => ArTestPageState();
}

class ArTestPageState extends State<ArTestPage> with AutomaticKeepAliveClientMixin {
  late StreamSubscription<Position> _positionStream;
  Position? _currentPosition;
  late ArCoreController _arCoreController;

  final HideTreasure _hideTreasure = HideTreasure();
  List<Treasure> huntTreasures = []; // Initialize with your treasures
  final double _renderRadius = 5.0; // Radius within which to render treasures
  bool _isClose = false;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    _arCoreController.dispose();
    super.dispose();
  }

  Future<void> _startLocationUpdates() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    try {
      _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position position) {
          setState(() {
            _currentPosition = position;
            if (_currentPosition != null) {
              _updateTreasurePositions();
              _renderTreasures();
            }
          });
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void _updateTreasurePositions() {
    if (_currentPosition != null) {
      _hideTreasure.placeArtifacts(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
    }
  }

  void _renderTreasures() {
    if (_arCoreController != null && _currentPosition != null) {
      for (var treasure in huntTreasures) {
        // Check if latitude and longitude are not null
        if (treasure.latitude != null && treasure.longitude != null) {
          double distance = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            treasure.latitude!,
            treasure.longitude!,
          );

          if (distance <= _renderRadius) {
            _addTreasureNode(treasure);
          } else if (distance > _renderRadius && distance <= 8) {
            _isClose = true;
          }
        }
      }
    }
  }


  Future<void> _addTreasureNode(Treasure treasure) async {
    final node = ArCoreReferenceNode(
      name: treasure.name,
      objectUrl: treasure.modelUrl,
      position: treasure.position,
      scale: vector.Vector3(1, 1, 1),
    );
    await _arCoreController.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AR Treasure Hunt'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enableUpdateListener: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    _arCoreController = controller;
    _arCoreController.onNodeTap = (name) => _onNodeTap(name);
    _updateTreasurePositions();
    _renderTreasures();
  }

  void _onNodeTap(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(content: Text('You found a treasure!')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
