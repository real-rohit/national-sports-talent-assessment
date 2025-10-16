import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/features/tests/endurance/endurance.dart';
import 'package:nsta_app/src/features/tests/height/heigh_test.dart';
import 'package:nsta_app/src/features/tests/shuttle_run/shuttle_run.dart';
import 'package:nsta_app/src/features/tests/sit-ups/sit-ups.dart';
import 'package:nsta_app/src/features/tests/veritcal_jump.dart/vertical_jump_intro_screen.dart';
import 'package:nsta_app/src/features/tests/sit_and_reach/sit_and_reach_intro_screen.dart';
import 'package:nsta_app/src/features/tests/broad_jump/broad_jump_intro_screen.dart';
import 'package:nsta_app/src/features/tests/medicine_ball/medicine_ball_intro_screen.dart';
import 'package:nsta_app/src/features/tests/sprint/sprint_intro_screen.dart';
import 'package:nsta_app/src/shared/widgets/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetStorage storage = GetStorage();
  File? imageFile;
  String userName = "User"; // default

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void loadImageFromStorage() {
    final savedPath = storage.read<String>('profile_image');
    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() => imageFile = File(savedPath));
    }
  }

  Future<void> fetchUserName() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _db.collection('users').doc(uid).get();
        if (doc.exists) {
          final data = doc.data();
          setState(() {
            userName = data?['name'] ?? "User";
          });
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadImageFromStorage();
    fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              child: imageFile == null
                  ? ClipOval(
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                    )
                  : null,
            ),
          ),
        ],
        title: Text(
          '${AppLocalizations.of(context)!.hi}.. $userName',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Row 1: Height, Weight
            Row(
              children: [
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.height, Icons.height,
                        onTap: () {
                  Get.to(HeightWeightIntroScreen());
                })),
                const SizedBox(width: 12),
                Expanded(
                    child: buildCard(AppLocalizations.of(context)!.weight,
                        Icons.monitor_weight, onTap: () {
                  Get.to(HeightWeightIntroScreen());
                })),
              ],
            ),
            const SizedBox(height: 12),

            // Row 2: Sit and Reach, Standing Vertical Jump
            Row(
              children: [
                Expanded(
                    child: buildCard(AppLocalizations.of(context)!.sitAndReach,
                        Icons.accessibility_new, onTap: () {
                  Get.to(SitAndReachIntroScreen());
                })),
                const SizedBox(width: 12),
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.standingVerticalJump,
                        Icons.sports_handball, onTap: () {
                  Get.to(VerticalJumpIntroScreen());
                })),
              ],
            ),
            const SizedBox(height: 12),

            // Row 3: Standing Broad Jump, Medicine Ball Throw
            Row(
              children: [
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.standingBroadJump,
                        Icons.directions_run, onTap: () {
                  Get.to(BroadJumpIntroScreen());
                })),
                const SizedBox(width: 12),
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.medicineBallThrow,
                        Icons.sports_volleyball, onTap: () {
                  Get.to(MedicineBallIntroScreen());
                })),
              ],
            ),
            const SizedBox(height: 12),

            // Row 4: 30m Sprint, 4x10m Shuttle Run
            Row(
              children: [
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.thirtyMeterSprint,
                        Icons.speed, onTap: () {
                  Get.to(SprintIntroScreen());
                })),
                const SizedBox(width: 12),
                Expanded(
                    child: buildCard(
                        AppLocalizations.of(context)!.fourByTenShuttleRun,
                        Icons.directions_run, onTap: () {
                  Get.to(ShuttleRunIntroScreen());
                })),
              ],
            ),
            const SizedBox(height: 12),

            // Row 5: Sit-ups, Endurance Run
            Row(
              children: [
                Expanded(
                    child: buildCard(AppLocalizations.of(context)!.sitUps,
                        Icons.fitness_center, onTap: () {
                  Get.to(SitUpsIntroScreen());
                })),
                const SizedBox(width: 12),
                Expanded(
                    child: buildCard(AppLocalizations.of(context)!.enduranceRun,
                        Icons.directions_run_outlined, onTap: () {
                  Get.to(EnduranceRunIntroScreen());
                })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
