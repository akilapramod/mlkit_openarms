// painters/pose_painter.dart
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final Map<String, dynamic> analysisResult;

  PosePainter(this.poses, this.absoluteImageSize, this.rotation, this.analysisResult);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.green;

    for (final pose in poses) {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
          Offset(
            landmark.x * size.width / absoluteImageSize.width,
            landmark.y * size.height / absoluteImageSize.height,
          ),
          1,
          paint,
        );
      });

      // Draw connecting lines for pose landmarks
      void drawLine(PoseLandmarkType type1, PoseLandmarkType type2) {
        final PoseLandmark? point1 = pose.landmarks[type1];
        final PoseLandmark? point2 = pose.landmarks[type2];

        if (point1 != null && point2 != null) {
          canvas.drawLine(
            Offset(
              point1.x * size.width / absoluteImageSize.width,
              point1.y * size.height / absoluteImageSize.height,
            ),
            Offset(
              point2.x * size.width / absoluteImageSize.width,
              point2.y * size.height / absoluteImageSize.height,
            ),
            paint,
          );
        }
      }

      // Draw body lines
      drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder);
      drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow);
      drawLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow);
      // Add more lines as needed
    }

    // Display the analysis result.
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${analysisResult["result"]} (${(analysisResult["confidence"] * 100).toStringAsFixed(0)}%)',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(canvas, Offset(10, 10)); // Adjust position as needed.
  }


  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses || oldDelegate.analysisResult != analysisResult;
  }
}