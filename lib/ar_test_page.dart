import 'dart:async';

import 'package:ar_test/database.dart';
import 'package:ar_test/services/location.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'models/treasures.dart';
import 'views/home_screen.dart';

class ArTestPage extends StatefulWidget {
  const ArTestPage({super.key});

  @override
  ArTestPageState createState() => ArTestPageState();
}

class ArTestPageState extends State<ArTestPage> {
  late StreamSubscription<Position> _positionStream;
  Position? _currentPosition;
  late ArCoreController arCoreController;
  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    arCoreController.dispose();
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
      distanceFilter: 0,
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
    var withinRad = 0.0;
    if (_currentPosition != null) {
      var playerLat = _currentPosition?.latitude;
      var playerLng = _currentPosition?.longitude;
      // debugPrint(playerLng!.toString());
      var a = Geolocator.getLastKnownPosition();
      var treasureLat = 6.6771571;
      var treasureLng = 3.361587;
      var distance = Geolocator.distanceBetween(
          playerLat!, playerLng!, treasureLat, treasureLng);
      setState(() {
        withinRad = distance;
      });
      debugPrint('Distance - $distance');
      // setState(() {
      //   withinRad = distance;
      // });
      // debugPrint(isTreasureNear.toString());
    }
 //   super.build(context);
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
          ),
          Positioned(
              top: 50,
              left: 24,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameHome()));                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              )),
          Positioned(
              bottom: 120,
              right: 24,
              child: GestureDetector(
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: const Center(
                      child: Icon(
                    Icons.emoji_objects,
                    color: Colors.white,
                    size: 32,
                  )),
                ),
              )),
          Positioned(
              bottom: 50,
              right: 24,
              child: GestureDetector(
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: Center(
                      child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                    size: 32,
                  )),
                ),
              )),
          Positioned(
              bottom: 50,
              left: 24,
              child: GestureDetector(
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  )),
                ),
              ))
        ]),
      )),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);

    var locationService = LocationService();
    var withinRad = 0.0;
    if (_currentPosition != null) {
      var playerLat = _currentPosition?.latitude;
      var playerLng = _currentPosition?.longitude;
      // debugPrint(playerLng!.toString());
      var treasureLat = 6.6771571;
      var treasureLng = 3.361587;
      setState(() {
        var distance = Geolocator.distanceBetween(
            playerLat!, playerLng!, treasureLat, treasureLng);

        debugPrint('Distance - $distance');
      });

      // setState(() {
      //   withinRad = distance;
      // });
      // debugPrint(isTreasureNear.toString());
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Within Range')));
    _addSphere(arCoreController, -3.0, -4.0, -5.0);
    _addSphere2(controller, 0, -2, -5.0);
    _addSphere3(controller, -1, -1, -5.0);
    _addCube(controller);

    //_addCylindre(arCoreController);
    //  _addCube(arCoreController);
  }

  // Future<void> _loadAssets(ArCoreController controller) async {

  //     final material = ArCoreMaterial(
  //       color: const Color.fromARGB(120, 66, 134, 244),
  //       // textureBytes: image.buffer.asUint8List(),
  //     );
  //     final sphere = ArCoreSphere(
  //       materials: [material],
  //       radius: 0.5,
  //     );
  //     final node = ArCoreNode(
  //       shape: sphere,
  //       name: huntTreasures[1].id,
  //       position: huntTreasures[1].position,
  //     );
  //     controller.addArCoreNode(node);

  // }

  Future<void> _addSphere(ArCoreController controller, double x, y, z) async {
    final ByteData image = await rootBundle.load('assets/Group.png');
    final material = ArCoreMaterial(
      color: Colors.red,
      // textureBytes: image.buffer.asUint8List(),
    );
    final material2 = ArCoreMaterial(
      color: Colors.yellow,
    );
    final material3 = ArCoreMaterial(
      color: Colors.blue,
    );
    final material4 = ArCoreMaterial(
      color: Colors.black,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.5,
    );
    final sphere2 = ArCoreSphere(materials: [material2], radius: 0.5);
    final sphere3 = ArCoreSphere(materials: [material3], radius: 0.5);
    final sphere4 = ArCoreSphere(materials: [material4], radius: 0.5);
    final node = ArCoreNode(
        name: '1',
        shape: sphere,
        position: vector.Vector3(x, y, z),
        children: [
          ArCoreNode(
            name: '2',
            shape: sphere2,
            position: vector.Vector3(-5.5, 1.5, -5.5),
          ),
          ArCoreNode(
            name: '3',
            shape: sphere3,
            position: vector.Vector3(-2.5, 4.0, -5.5),
          ),
          ArCoreNode(
            name: '4',
            shape: sphere4,
            position: vector.Vector3(-0.5, 8.5, -5.5),
          ),
        ]
        //TODO: Check if this works fine.
        //image: ArCoreImage(bytes: image.buffer.asUint8List())
        );
    controller.addArCoreNode(node);
  }

  Future<void> _addSphere2(ArCoreController controller, double x, y, z) async {
    final ByteData image = await rootBundle.load('assets/Group.png');
    final material = ArCoreMaterial(
      color: Colors.blue,
      // textureBytes: image.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.5,
    );
    final node = ArCoreNode(
      name: '2',
      shape: sphere,
      position: vector.Vector3(x, y, z),
      //TODO: Check if this works fine.
      //image: ArCoreImage(bytes: image.buffer.asUint8List())
    );
    controller.addArCoreNode(node);
  }

  Future<void> _addSphere3(ArCoreController controller, double x, y, z) async {
    final ByteData image = await rootBundle.load('assets/Group.png');
    final material = ArCoreMaterial(
      color: Colors.yellow,
      // textureBytes: image.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.5,
    );
    final node = ArCoreNode(
      name: '3',
      shape: sphere,
      position: vector.Vector3(x, y, z),
      //TODO: Check if this works fine.
      //image: ArCoreImage(bytes: image.buffer.asUint8List())
    );
    controller.addArCoreNode(node);
  }

  Future<void> _addCylindre(ArCoreController controller) async {
    //final ByteData image = await rootBundle.load('assets/m1.png');
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
      //textureBytes: image.buffer.asUint8List(),
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    // controller.onNodeTap
    //controller.id = 1;
    //controller.onNodeTap = _onNodeTap;
    controller.addArCoreNode(node);
  }

  void _onNodeTap(String s) {
    debugPrint('SOMETHING');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  void onTapHandler(String name) {
    // Navigator.push
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('You found a treasure!')),
    );
  }

  void _addCube(ArCoreController controller) async {
    final ByteData image = await rootBundle.load('assets/Group.png');
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      metallic: 1.0,
      textureBytes: image.buffer.asUint8List(),
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      name: 'test',
      shape: cube,
      position: vector.Vector3(-0.5, 1.5, -5.5),
      children: [
        ArCoreNode(
          name: 'test2',
          shape: cube,
          position: vector.Vector3(-1.5, 1.5, -5.5),
        )
      ],
    );
    controller.addArCoreNode(node);
  }

  //We do not want to keep the tab persisted all the time
  //TODO: Find a more performant way of keeping the tab alive.
  @override
  bool get wantKeepAlive => true;
}
