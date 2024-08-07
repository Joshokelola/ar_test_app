import 'package:ar_test/database.dart';
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
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 1.5, color: Colors.white)),
                ),
              ))
        ]),
      )),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
    arCoreController.onNodeTap = _handleNodeTap;
    _addSphere(arCoreController);
    // _addCylindre(arCoreController);
    // _addCube(arCoreController);
    _loadTreasures();
  }

  void _loadTreasures() {
    // Define treasure locations and models here
    final treasures = huntTreasures;
    for (var treasure in treasures) {
      final node = ArCoreReferenceNode(
        name: treasure.name,
        objectUrl: treasure.modelUrl,
        position: treasure.position,
        scale: vector.Vector3(1, 1, 1),
      );
      arCoreController.addArCoreNode(node);
    }
  }

  void _handleNodeTap(String nodeName) {
    if (nodeName.isNotEmpty) {
      final tappedNode = nodeName;
      // Handle the treasure interaction, e.g., mark as collected
      print('Tapped on $tappedNode');
      // Update game state and remove node
      arCoreController.removeNode(nodeName: tappedNode);
    }
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
    final material =
        ArCoreMaterial(color: const Color.fromARGB(120, 66, 134, 244));
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

  void _addCylindre(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
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
    controller.addArCoreNode(node);
  }

  void _addCube(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
