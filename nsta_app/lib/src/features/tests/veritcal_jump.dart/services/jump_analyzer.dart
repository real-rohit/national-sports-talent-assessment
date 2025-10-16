
import 'dart:math';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class JumpAnalyzer {
  final List<double> _hipHistory = [];
  double? _baselineHipY; // standing hip y
  double? _minHipY; // peak (smallest y)
  bool _jumpInProgress = false;

  void reset() {
    _hipHistory.clear();
    _baselineHipY = null;
    _minHipY = null;
    _jumpInProgress = false;
  }

  void updateWithPose(Pose pose) {
    final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
    final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
    if (leftHip == null || rightHip == null) return;

    final hipY = (leftHip.y + rightHip.y) / 2.0;

    // maintain a history for baseline estimation
    _hipHistory.add(hipY);
    if (_hipHistory.length > 60) _hipHistory.removeAt(0);

    if (_baselineHipY == null && _hipHistory.length >= 30) {
      // estimate baseline as median of history
      final sorted = [..._hipHistory]..sort();
      _baselineHipY = sorted[(sorted.length / 2).floor()];
    }

    if (_baselineHipY != null) {
      // update min hip y while jump in progress
      if (hipY < (_minHipY ?? double.infinity)) {
        _minHipY = hipY;
      }

      // detect start of jump: hip moves upward significantly
      if (!_jumpInProgress && hipY < _baselineHipY! - 10) {
        _jumpInProgress = true;
      }

      // detect landing: hip returns near baseline
      if (_jumpInProgress && hipY > _baselineHipY! - 5) {
        _jumpInProgress = false;
        // at landing we keep _minHipY as the peak for the jump
      }
    }
  }

  /// Returns latest jump height in cm if available, otherwise null.
  /// userHeightCm: user's real height in centimeters. If null, conversion uses an assumed ratio and returns a rough value.
  double? getLatestJumpCm({double? userHeightCm, required Pose pose}) {
    if (_baselineHipY == null || _minHipY == null) return null;

    // Compute person pixel height from landmarks (nose to average of ankles)
    final nose = pose.landmarks[PoseLandmarkType.nose];
    final leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle];
    final rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle];
    if (nose == null || leftAnkle == null || rightAnkle == null) return null;

    final ankleY = (leftAnkle.y + rightAnkle.y) / 2.0;
    final pixelHeight = (ankleY - nose.y).abs();

    double pixelsPerCm;
    if (userHeightCm != null && userHeightCm > 0) {
      // Estimate pixel height to real height roughly: nose-to-ankle fraction of full height ~ 0.95
      final estimatedPersonHeightCm = userHeightCm * 0.95; // nose to ankles ~95%
      pixelsPerCm = pixelHeight / estimatedPersonHeightCm;
      if (pixelsPerCm <= 0) return null;
    } else {
      // fallback: assume a typical pixels-per-cm ratio (very rough). We return null to indicate unsure.
      return null;
    }

    final deltaPixels = _baselineHipY! - _minHipY!; // baseline is larger, min is smaller
    final deltaCm = deltaPixels / pixelsPerCm;
    return deltaCm;
  }
}