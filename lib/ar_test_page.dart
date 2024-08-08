// import 'dart:async';
// import 'dart:math';
// import 'package:heritage_quest/database.dart';
// import 'package:heritage_quest/models/treasures.dart';
// import 'package:heritage_quest/services/treasure_location.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class ArTestPage extends StatefulWidget {
//   const ArTestPage({super.key});

//   @override
//   ArTestPageState createState() => ArTestPageState();
// }

// class ArTestPageState extends State<ArTestPage>
//     with AutomaticKeepAliveClientMixin {
//   late StreamSubscription<Position> _positionStream;
//   Position? _currentPosition;
//   late ArCoreController _arCoreController;

//   final HideTreasure _hideTreasure = HideTreasure();
//   List<Treasure> huntTreasures = []; // Initialize with your treasures
//   final double _renderRadius = 5.0; // Radius within which to render treasures
//   bool _isClose = false;

//   @override
//   void initState() {
//     super.initState();
//     _startLocationUpdates();
//   }

//   @override
//   void dispose() {
//     _positionStream.cancel();
//     _arCoreController.dispose();
//     super.dispose();
//   }

//   Future<void> _startLocationUpdates() async {
//     var permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied.');
//     }

//     const locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.bestForNavigation,
//       distanceFilter: 0,
//     );

//     try {
//       _positionStream =
//           Geolocator.getPositionStream(locationSettings: locationSettings)
//               .listen(
//         (Position position) {
//           setState(() {
//             _currentPosition = position;
//             if (_currentPosition != null) {
//               _updateTreasurePositions();
//               _renderTreasures();
//             }
//           });
//         },
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _updateTreasurePositions() {
//     if (_currentPosition != null) {
//       _hideTreasure.placeArtifacts(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//       );
//     }
//   }

//   void _renderTreasures() {
//     if (_currentPosition != null) {
//       for (var treasure in huntTreasures) {
//         // Check if latitude and longitude are not null
//         if (treasure.latitude != null && treasure.longitude != null) {
//           debugPrint('lat - ${treasure.latitude} lng - ${treasure.longitude}');
//           double distance = Geolocator.distanceBetween(
//             _currentPosition!.latitude,
//             _currentPosition!.longitude,
//             treasure.latitude!,
//             treasure.longitude!,
//           );

//           if (distance <= _renderRadius) {
//             _addTreasureNode(treasure);
//           } else if (distance > _renderRadius && distance <= 8) {
//             _isClose = true;
//           }
//         }
//       }
//     }
//   }

//   Future<void> _addTreasureNode(Treasure treasure) async {
//     final node = ArCoreReferenceNode(
//       name: treasure.name,
//       objectUrl: treasure.modelUrl,
//       position: treasure.position,
//       scale: vector.Vector3(1, 1, 1),
//     );
//     await _arCoreController.addArCoreNode(node);
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('AR Treasure Hunt'),
//         ),
//         body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//           enableTapRecognizer: true,
//           enableUpdateListener: true,
//         ),
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     _arCoreController = controller;
//     _arCoreController.onNodeTap = (name) => _onNodeTap(name);
//     _updateTreasurePositions();
//     _renderTreasures();
//   }

//   void _onNodeTap(String name) {
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) =>
//           AlertDialog(content: Text('You found a treasure!')),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

import 'package:heritage_quest/database.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArTestPage extends StatefulWidget {
  const ArTestPage({super.key});

  @override
  ArTestPageState createState() => ArTestPageState();
}

class ArTestPageState extends State<ArTestPage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
    arCoreController.onNodeTap = _handleOnNodeTap;
    arCoreController.addArCoreNode(ArCoreReferenceNode(
      name: huntTreasures[10].name,
      position: vector.Vector3(0, 0, -5),
      scale: vector.Vector3(0.1, 0.1, 0.1),
      objectUrl:
          'https://github.com/Joshokelola/heritage_hunt/raw/main/assets/treasure%20models/igbo_odogwu_hand_fan_3d_model.glb',
    ));
    _addSphere(arCoreController);
  }

  void _handleOnNodeTap(String name) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('You found $name item. \n rarity:${huntTreasures[10].rarity}'),
          );
        });
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    if (hits.isNotEmpty) {
      final hit = hits.first;
      _addImage(hit);
    }
  }

  Future _addImage(ArCoreHitTestResult hit) async {
    final bytes =
        (await rootBundle.load('assets/character.png')).buffer.asUint8List();

    final earth = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 500, height: 500),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController.addArCoreNode(earth);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(color: Color.fromARGB(120, 66, 134, 244));
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
