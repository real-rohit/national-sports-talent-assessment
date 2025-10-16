// import 'package:flutter/material.dart';
// import 'package:nsta_app/src/shared/widgets/buttons.dart';
// import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';
// import 'package:nsta_app/src/shared/widgets/sections.dart';

// class CameraTestScreen extends StatelessWidget {
//   static const String route = '/tests/camera';
//   const CameraTestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double minPad = MediaQuery.of(context).size.width > 600 ? 24 : 16;
//     return Scaffold(
//     appBar:CustomAppBar2(title: 'Vertical Jump test', icon: Icons.arrow_back_rounded),      body: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.all(minPad),
//           children: [
//             AspectRatio(
//               aspectRatio: 9/16,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.image_outlined, size: 80, color: Colors.black38),
//                     SizedBox(height: 12),
//                     Pill(text: 'Correct Form', icon: Icons.check_circle_outline),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text('Position yourself to match the silhouette, then start recording.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
//             const SizedBox(height: 16),
//             PrimaryButton(
//               label: 'Start Recording',
//               onPressed: () => Navigator.of(context).pushNamed('/tests/result'),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'package:provider/provider.dart';
import 'package:nsta_app/src/features/tests/veritcal_jump.dart/services/jump_analyzer.dart';
import 'package:nsta_app/src/features/tests/veritcal_jump.dart/services/pose_detector_service.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/pose_painter.dart';

class CameraTestScreen extends StatefulWidget {
  static const String route = '/tests/camera';
  const CameraTestScreen({super.key});

  @override
  State<CameraTestScreen> createState() => _CameraTestScreenState();
}

class _CameraTestScreenState extends State<CameraTestScreen> {
  CameraController? _cameraController;
  late PoseDetectorService _poseService;
  late JumpAnalyzer _jumpAnalyzer;
  bool _isDetecting = false;
  CustomPaint? _customPaint;
  double? _displayedJumpCm;
  bool _recording = false;
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _poseService = PoseDetectorService();
    _jumpAnalyzer = JumpAnalyzer();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final backCam = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      backCam,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    // Start image stream
    await _cameraController!.startImageStream(_processCameraImage);
    setState(() {});
  }

  void _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    try {
      final InputImage inputImage = _poseService.convertCameraImage(
          image, _cameraController!.description.sensorOrientation);
      final List<Pose> poses = await _poseService.processImage(inputImage);

      if (poses.isNotEmpty) {
        final pose = poses.first;

        // Analyze jump using landmark coordinates
        _jumpAnalyzer.updateWithPose(pose);
        final resultMeters = _jumpAnalyzer.getLatestJumpCm(
          userHeightCm: _parseHeightInput(),
          pose: pose,
        );

        setState(() {
          _displayedJumpCm = resultMeters;
          _customPaint = CustomPaint(
            painter: PosePainter(pose, _cameraController!.value.previewSize!,
                _cameraController!.description.sensorOrientation),
          );
        });
      }
    } catch (e) {
      // print(e);
    } finally {
      _isDetecting = false;
    }
  }

  double? _parseHeightInput() {
    final text = _heightController.text.trim();
    if (text.isEmpty) return null;
    final v = double.tryParse(text);
    return v;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _poseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double minPad = MediaQuery.of(context).size.width > 600 ? 24 : 16;

    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.verticalJumpTest)),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(minPad),
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _cameraController == null ||
                        !_cameraController!.value.isInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          CameraPreview(_cameraController!),
                          if (_customPaint != null) _customPaint!,
                          Positioned(
                            left: 12,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)!.jump(
                                          _displayedJumpCm == null
                                              ? "--"
                                              : _displayedJumpCm!
                                                  .toStringAsFixed(1)),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 120,
                                    child: TextField(
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .yourHeightCm,
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintStyle: const TextStyle(
                                              color: Colors.white70)),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.positionInstruction,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            PrimaryButton(
              label: _recording
                  ? AppLocalizations.of(context)!.stopAndProcess
                  : AppLocalizations.of(context)!.startRecording,
              onPressed: () {
                setState(() {
                  _recording = !_recording;
                  if (_recording) {
                    _jumpAnalyzer.reset();
                  }
                });
              },
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final value = _displayedJumpCm ?? 0.0;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.jumpResult),
                    content:
                        Text(AppLocalizations.of(context)!.measuredJump(value)),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppLocalizations.of(context)!.ok)),
                    ],
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.showResult),
            ),
          ],
        ),
      ),
    );
  }
}
