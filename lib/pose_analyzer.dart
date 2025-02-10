import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

bool areArmsOpen(Pose pose) {
  // Extract landmarks.
  final PoseLandmark? leftWrist = pose.landmarks[PoseLandmarkType.leftWrist];
  final PoseLandmark? rightWrist = pose.landmarks[PoseLandmarkType.rightWrist];
  final PoseLandmark? leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
  final PoseLandmark? rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];

  // Check if all required landmarks are present.
  if (leftWrist == null || rightWrist == null || leftShoulder == null || rightShoulder == null) {
    return false; // Return false if landmarks are missing
  }

  // Calculate shoulder width for normalization.
  final shoulderWidth = (leftShoulder.x - rightShoulder.x).abs();

  // Calculate the horizontal distance between the wrists.
  final wristDistanceX = (leftWrist.x - rightWrist.x).abs();

  // Use the original open arms threshold.
  final openArmsThreshold = shoulderWidth * 0.7;

  // Return true if the wrist distance is greater than the threshold, false otherwise.
  return wristDistanceX > openArmsThreshold;
}