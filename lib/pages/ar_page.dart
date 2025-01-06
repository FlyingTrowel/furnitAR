import 'package:flutter/material.dart';

//AR Flutter Plugin
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_flutterflow/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_hittest_result.dart';

//Other custom imports
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';

class ARPage extends StatefulWidget {
  const ARPage({
    super.key,
    this.width,
    this.height,
});

  final double? width;
  final double? height;

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  late Map<String, String> model;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    print(model["model"]);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Container(
        child: Stack( children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: (model['plane'] == 'horizontal') ? PlaneDetectionConfig.horizontal : PlaneDetectionConfig.vertical,
          ),
        ],),
      ),
      );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "Images/triangle.png",
      showWorldOrigin: false,

    );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    AlertDialog(
      title: Text("Information"),
      content: Text("Tapped $number node(s)"),
    );
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
      ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        this.anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri:
            // "https://files.catbox.moe/bzrwjg.glb",
            "https://github.com/FlyingTrowel/furnitAR/raw/refs/heads/main/assets/models/${model["model"]}",
            // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/refs/heads/main/2.0/Duck/glTF-Binary/Duck.glb",
            scale: Vector3(1.0, 1.0, 1.0),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor = await this
            .arObjectManager!
            .addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          this.nodes.add(newNode);
        } else {
          AlertDialog(
            title: Text("Error"),
            content: Text("Adding Node to Anchor failed"),
          );
        }
      } else {
        AlertDialog(
          title: Text("Error"),
          content: Text("Adding Anchor failed"),
        );
      }
      /*
      // To add a node to the tapped position without creating an anchor, use the following code (Please mind: the function onRemoveEverything has to be adapted accordingly!):
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "Models/Chicken_01/Chicken_01.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          transformation: singleHitTestResult.worldTransform);
      bool didAddWebNode = await this.arObjectManager.addNode(newNode);
      if (didAddWebNode) {
        this.nodes.add(newNode);
      }*/
    }
  }
}
