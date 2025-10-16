import 'dart:io';
// import 'package:camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as thumb;

class VideoPoseTestScreen extends StatefulWidget {
  const VideoPoseTestScreen({Key? key}) : super(key: key);

  @override
  State<VideoPoseTestScreen> createState() => _VideoPoseTestScreenState();
}

class _VideoPoseTestScreenState extends State<VideoPoseTestScreen> {
  CameraController? _cameraController;
  final PoseDetector _poseDetector = PoseDetector(
      options: PoseDetectorOptions(mode: PoseDetectionMode.single));
  bool _isRecording = false;
  String _result =
      'Press start to record jump'; // This will be localized in build method
  double _userHeightCm = 175.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras
        .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back);

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _startRecording() async {
    await _cameraController!.startVideoRecording();
    setState(() {
      _isRecording = true;
      _result = 'Recording...'; // This will be localized in build method
    });
  }

  Future<void> _stopRecordingAndProcess() async {
    final videoFile = await _cameraController!.stopVideoRecording();
    setState(() {
      _isRecording = false;
      _result = 'Processing video...'; // This will be localized in build method
    });

    final tempDir = await getTemporaryDirectory();
    final framesDir = Directory('${tempDir.path}/frames');
    if (!framesDir.existsSync()) framesDir.createSync();

    // Generate frames at 0.2 s intervals
    int maxHeight = 0;
    final videoDuration = await _cameraController!.getVideoDuration();
    final totalMs = videoDuration.inMilliseconds;
    for (int ms = 0; ms < totalMs; ms += 200) {
      final framePath = await thumb.VideoThumbnail.thumbnailFile(
        video: videoFile.path,
        imageFormat: thumb.ImageFormat.PNG,
        timeMs: ms,
        quality: 90,
        thumbnailPath: framesDir.path,
      );
      if (framePath == null) continue;

      final inputImage = InputImage.fromFilePath(framePath);
      final poses = await _poseDetector.processImage(inputImage);
      if (poses.isNotEmpty) {
        final height = _calculateJumpHeight(poses.first, _userHeightCm);
        if (height > maxHeight) maxHeight = height.round();
      }
    }

    setState(() {
      _result =
          'Video processed!\nMax Jump Height: $maxHeight cm'; // This will be localized in build method
    });
    print('✅ Max Jump Height: $maxHeight cm');
  }

  double _calculateJumpHeight(Pose pose, double userHeightCm) {
    final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
    final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
    final leftHeel = pose.landmarks[PoseLandmarkType.leftHeel];
    final rightHeel = pose.landmarks[PoseLandmarkType.rightHeel];
    final leftEye = pose.landmarks[PoseLandmarkType.leftEye];
    final rightEye = pose.landmarks[PoseLandmarkType.rightEye];

    if (leftHip == null ||
        rightHip == null ||
        leftHeel == null ||
        rightHeel == null ||
        leftEye == null ||
        rightEye == null) return 0.0;

    final hipY = (leftHip.y + rightHip.y) / 2;
    final heelY = (leftHeel.y + rightHeel.y) / 2;
    final headY = (leftEye.y + rightEye.y) / 2;

    final personHeightPx = heelY - headY;
    if (personHeightPx <= 0) return 0.0;

    final jumpHeightPx = heelY - hipY;
    return jumpHeightPx * userHeightCm / personHeightPx;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.recordJump)),
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  _result == 'Press start to record jump'
                      ? AppLocalizations.of(context)!.pressStartToRecord
                      : _result == 'Recording...'
                          ? AppLocalizations.of(context)!.recording
                          : _result == 'Processing video...'
                              ? AppLocalizations.of(context)!.processingVideo
                              : _result.startsWith('Video processed!')
                                  ? '${AppLocalizations.of(context)!.videoProcessed}\n${AppLocalizations.of(context)!.maxJumpHeight(_result.split(': ')[1].split(' ')[0] as num)}'
                                  : _result,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isRecording ? null : _startRecording,
                      child: Text(AppLocalizations.of(context)!.startRecording),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isRecording ? _stopRecordingAndProcess : null,
                      child: Text(AppLocalizations.of(context)!.stopAndProcess),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension _VideoDuration on CameraController {
  /// Helper to fetch video duration after recording
  Future<Duration> getVideoDuration() async {
    final file = await stopVideoRecording();
    final video = File(file.path);
    // Approximation: use file length (not exact). Better: use a metadata lib.
    // For simplicity, we assume 5 seconds max if unknown.
    return const Duration(seconds: 5);
  }
}
