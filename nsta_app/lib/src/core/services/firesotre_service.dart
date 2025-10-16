import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static Future<void> updateAthleteProfile({
    required String name,
    required String age,
    required String gender,
    required String location,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final uid = _auth.currentUser!.uid;

      

      await _db.collection('users').doc(uid).set({
        'name': name,
        'age': age,
        'gender': gender,
        'location': location,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      onSuccess();
    } on FirebaseException catch (e) {
      onError(e.message ?? 'Profile update failed');
    }
  }
}
