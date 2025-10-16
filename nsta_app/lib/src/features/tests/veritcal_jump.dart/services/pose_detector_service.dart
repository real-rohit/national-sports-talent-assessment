import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectorService {
  final PoseDetector _detector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  void close() => _detector.close();

  Future<List<Pose>> processImage(InputImage image) async {
    return await _detector.processImage(image);
  }

  /// Converts [CameraImage] to [InputImage] for ML Kit
  InputImage convertCameraImage(CameraImage cameraImage, int rotation) {
    // ✅ Use ByteData + BytesBuilder instead of WriteBuffer
    final bytesBuilder = BytesBuilder();
    for (final plane in cameraImage.planes) {
      bytesBuilder.add(plane.bytes);
    }
    final bytes = bytesBuilder.toBytes();

    // ✅ Use InputImage.fromBytes directly
    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: ui.Size(
          cameraImage.width.toDouble(),
          cameraImage.height.toDouble(),
        ),
        rotation: InputImageRotationValue.fromRawValue(rotation)
            ?? InputImageRotation.rotation0deg,
        format: InputImageFormatValue.fromRawValue(cameraImage.format.raw)
            ?? InputImageFormat.nv21,
        bytesPerRow: cameraImage.planes.first.bytesPerRow,
      ),
    );
  }
}
