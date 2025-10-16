import 'dart:math';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/features/auth/login_screen.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static String generateUserId() {
    final random = Random();
    String id = '';
    for (int i = 0; i < 6; i++) {
      id += random.nextInt(10).toString();
    }
    return id;
  }

  static Future<void> signUpWithEmail({
    required String name,
    required String phone,
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = generateUserId();
      final box = GetStorage();
      box.write('userId', userId);

      await _db.collection('users').doc(userId).set({
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': userId,
      }, SetOptions(merge: true));

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'Sign up failed');
    }
  }

  /// Existing email login
  static Future<void> signInWithEmail({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'Sign in failed');
    }
  }

  // ---- Phone OTP functions (unchanged) ----
  static Future<void> sendOtp({
    required String phone,
    required Function(String verificationId) onCodeSent,
    required Function(String message) onError,
    required Function() onAutoVerified,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (cred) async {
        await _auth.signInWithCredential(cred);
        onAutoVerified();
      },
      verificationFailed: (e) => onError(e.message ?? 'Verification failed'),
      codeSent: (id, _) => onCodeSent(id),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  static Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(cred);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'OTP verification failed');
    }
  }

  static User? get currentUser => _auth.currentUser;
  static Future<void> signOut() async {
    print('inside sign out function');
    final box = GetStorage();
    await box.remove('userId');
    await _auth.signOut();
    Get.off(() => LoginScreen());
  }
}
