import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArTestPage extends StatefulWidget {
  const ArTestPage({super.key});

  @override
  ArTestPageState createState() => ArTestPageState();
}

class ArTestPageState extends State<ArTestPage>
    with AutomaticKeepAliveClientMixin {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.addArCoreNode(
      ArCoreReferenceNode(
        name: 'MyModel',
        
        objectUrl: 'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Duck/glTF/Duck.gltf',
        position: vector.Vector3(0, 0, 0),
        scale: vector.Vector3(0.1, 0.1, 0.1),
        rotation: vector.Vector4(0, 0, 0, 0),
        // Other properties
      ),
    );
    _addSphere(arCoreController);
    _addCylindre(arCoreController);
    _addCube(arCoreController);
  }

  Future<void> _addSphere(ArCoreController controller) async {
    final ByteData image = await rootBundle.load('assets/Group.png');
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: image.buffer.asUint8List(),
    );
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

  Future<void> _addCylindre(ArCoreController controller) async {
      final ByteData image = await rootBundle.load('assets/m1.png');
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
      textureBytes: image.buffer.asUint8List(),
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

  //We do not want to keep the tab persisted all the time
  //TODO: Find a more performant way of keeping the tab alive.
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
