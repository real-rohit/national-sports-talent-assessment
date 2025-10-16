import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsta_app/src/features/homescreen/dashboard_screen.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final _storage = GetStorage();
  String? _sport;
  File? _imageFile;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    final savedPath = _storage.read<String>('profile_image');
    if (savedPath != null && File(savedPath).existsSync()) {
      _imageFile = File(savedPath);
    }
  }

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.camera);

      if (picked != null) {
        final directory = await getApplicationDocumentsDirectory();
        final path = p.join(
          directory.path,
          'profile_${DateTime.now().millisecondsSinceEpoch}.png',
        );
        final savedImage = await File(picked.path).copy(path);
        await _storage.write('profile_image', savedImage.path);
        setState(() => _imageFile = savedImage);
      }
    } catch (e) {
      debugPrint('Error picking or saving image: $e');
    }
  }

  Future<void> _saveProfile() async {
    if (_height.text.isEmpty || _weight.text.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.pleaseEnterHeightWeight,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // final uid = _auth.currentUser!.uid;
    final box = GetStorage();
    final uid = box.read('userId');

    try {
      await _db.collection('users').doc(uid).set({
        'height': _height.text.trim(),
        'weight': _weight.text.trim(),
        'sport': _sport,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      Get.snackbar(AppLocalizations.of(context)!.success,
          AppLocalizations.of(context)!.profileUpdatedSuccessfully,
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => const DashboardScreen());
    } on FirebaseException catch (e) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          e.message ?? AppLocalizations.of(context)!.profileUpdateFailed,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: AppLocalizations.of(context)!.profileSetup,
        icon: Icons.arrow_back_outlined,
        onPressed: () => Get.back(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.person,
                              size: 40, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Icon(Icons.edit,
                            size: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.heightCm,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _height,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.heightCm,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.weightKg,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.weightKg,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.sportPreferenceOptional,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: Text(AppLocalizations.of(context)!.selectASport),
              value: _sport,
              onChanged: (v) => setState(() => _sport = v),
              items: [
                DropdownMenuItem(
                    value: 'football',
                    child: Text(AppLocalizations.of(context)!.football)),
                DropdownMenuItem(
                    value: 'basketball',
                    child: Text(AppLocalizations.of(context)!.basketball)),
                DropdownMenuItem(
                    value: 'cricket',
                    child: Text(AppLocalizations.of(context)!.cricket)),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: AppLocalizations.of(context)!.saveAndGoToDashboard,
              onPressed: _saveProfile,
            ),
          ],
        ),
      ),
    );
  }
}
