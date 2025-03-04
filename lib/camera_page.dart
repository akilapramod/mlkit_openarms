// screens/camera_page.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'pose_painter.dart';
import 'pose_analyzer.dart';


class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final PoseDetector _poseDetector =
  PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  Map<String, dynamic> _poseAnalysisResult = {"result": "undetermined", "confidence": 0.0};

  @override
  void dispose() {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      customPaint: _customPaint,
      onImage: _processImage,
      initialCameraLensDirection: CameraLensDirection.back,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final poses = await _poseDetector.processImage(inputImage);
    if (poses.isNotEmpty) {
      final pose = poses.first;
      // Analyze the pose.
      _poseAnalysisResult = {"result": areArmsOpen(pose) ? "open arms" : "not open arms", "confidence" : 0.0};
      // Print pose landmarks to console
      // pose.landmarks.forEach((key, point) {
      //   print('${key.name}: (${point.x}, ${point.y})');
      // });
    }

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _poseAnalysisResult, // Pass the result to the painter.
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}