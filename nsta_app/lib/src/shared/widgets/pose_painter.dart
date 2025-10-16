import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';


class PosePainter extends CustomPainter {
final Pose pose;
final Size imageSize;
final int rotation;


PosePainter(this.pose, this.imageSize, this.rotation);


@override
void paint(Canvas canvas, Size size) {
final paint = Paint()
..style = PaintingStyle.stroke
..strokeWidth = 2.0
..color = Colors.greenAccent;


// The camera preview might be rotated or mirrored depending on device; we do a simple scale mapping here.
final scaleX = size.width / imageSize.height; // note: camera preview tends to swap width/height
final scaleY = size.height / imageSize.width;


// helper to map
Offset translateXY(double x, double y) {
// depending on rotation, mapping may differ. For common phones rotation=90 allows using this transform.
return Offset(y * scaleX, x * scaleY);
}


// draw keypoints
for (final landmark in pose.landmarks.values) {
final offset = translateXY(landmark.x, landmark.y);
canvas.drawCircle(offset, 4.0, paint);
}


// draw skeleton lines for a few connections
void drawLineIfExists(PoseLandmarkType a, PoseLandmarkType b) {
final p1 = pose.landmarks[a];
final p2 = pose.landmarks[b];
if (p1 != null && p2 != null) {
canvas.drawLine(translateXY(p1.x, p1.y), translateXY(p2.x, p2.y), paint);
}
}


drawLineIfExists(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder);
drawLineIfExists(PoseLandmarkType.leftHip, PoseLandmarkType.rightHip);
drawLineIfExists(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow);
drawLineIfExists(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow);
drawLineIfExists(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee);
drawLineIfExists(PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee);
}


@override
bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}