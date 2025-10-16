import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsta_app/src/features/auth/login_screen.dart';
import 'package:nsta_app/src/features/profile/create_profile_screen.dart';
import 'package:nsta_app/src/features/homescreen/dashboard_screen.dart';
import 'package:nsta_app/src/features/profile/profile_setup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    final userId = box.read('userId');
    await Future.delayed(Duration(milliseconds: 2500));

    if (userId == null) {
      Get.offAll(() => LoginScreen());
      return;
    }

    try {
      print("User Id========= $userId");
      final doc = await _firestore.collection('users').doc(userId).get();

      print('Data from fireStore: ${doc.data()}');

      if (doc.exists) {
        final data = doc.data();
        final height = data?['height'];
        final weight = data?['weight'];

        if (height != null &&
            height.toString().isNotEmpty &&
            weight != null &&
            weight.toString().isNotEmpty) {
          Get.offAll(() => const DashboardScreen());
          return;
        }
      }

      Get.offAll(() => const CreateProfileScreen());
    } catch (e) {
      print("Firestore error: $e");
      Get.offAll(() => const CreateProfileScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8a2322), Color(0xffe38122)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                Icons.add_circle_outline_rounded,
                size: 120.0,
                color: Colors.white.withOpacity(0.25),
              ),
              const Spacer(),
              const Text(
                'Powered by Sports Authority of India',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.red.shade400),
                  backgroundColor: Colors.white.withOpacity(0.2),
                  minHeight: 2.0,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
