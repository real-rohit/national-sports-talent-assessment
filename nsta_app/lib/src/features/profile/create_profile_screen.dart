import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsta_app/src/core/services/firesotre_service.dart';
import 'package:nsta_app/src/features/homescreen/dashboard_screen.dart';
import 'package:nsta_app/src/features/profile/profile_setup_screen.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class CreateProfileScreen extends StatefulWidget {
  // static const String route = '/create-profile';
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? _gender;
  bool _isFetchingLocation = false;
  String? _sport;
  File? _imageFile;
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _fetchUserCity();
  }

  Future<void> _fetchUserCity() async {
    setState(() => _isFetchingLocation = true);

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _locationController.text =
            AppLocalizations.of(context)!.permissionDenied;
        _isFetchingLocation = false;
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final city = placemarks.first.locality ??
            placemarks.first.administrativeArea ??
            placemarks.first.country ??
            AppLocalizations.of(context)!.unknown;
        // setState(() => _locationController.text = city);
        setState(() {
          print(_locationController.text);
          _locationController.text = city;
          _isFetchingLocation = false;
        });
      } else {
        setState(() =>
            _locationController.text = AppLocalizations.of(context)!.unknown);
      }
    } catch (_) {
      setState(() => _locationController.text =
          AppLocalizations.of(context)!.errorFetchingLocation);
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _saveProfile() async {
    final name = _name.text.trim();
    final age = _age.text.trim();
    final gender = _gender;
    final location = _locationController.text.trim();
    final height = _height.text.trim();
    final weight = _weight.text.trim();
    final sport = _sport;

    if (name.isEmpty) return print("Name is empty");
    if (age.isEmpty) return print("Age is empty");
    if (gender == null || gender.isEmpty) return print("Gender not selected");
    if (location.isEmpty) return print("Location is empty");

    try {
      print("Starting profile save...");

      // If you want to upload profile image first
      String? imageUrl;
      if (_imageFile != null) {
        print("Uploading profile image...");
        print("Image uploaded: $imageUrl");
      }

      final uid = GetStorage().read('userId') ??
          "anonymous"; // replace with auth user id if available
      final profileData = {
        'name': name,
        'age': age,
        'gender': gender.toString(),
        'location': location,
        'height': height,
        'weight': weight,
        'sport': sport ?? '',
        'profile_image': imageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      };

      print("Saving profile data to Firestore...");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(profileData, SetOptions(merge: true));
      print("Profile saved successfully!");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully!")),
      );

      // Navigate to next screen
      Get.to(() => const DashboardScreen());
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save profile: $e")),
      );
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _locationController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.createAthleteProfile),
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

            // Full Name
            Text(AppLocalizations.of(context)!.fullName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterYourFullName,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Age
            Text(AppLocalizations.of(context)!.age,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterYourAge,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Gender
            Text(AppLocalizations.of(context)!.gender,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: Text(AppLocalizations.of(context)!.selectYourGender),
              value: _gender,
              onChanged: (value) => setState(() => _gender = value),
              items: [
                DropdownMenuItem(
                    value: "male",
                    child: Text(AppLocalizations.of(context)!.male)),
                DropdownMenuItem(
                    value: "female",
                    child: Text(AppLocalizations.of(context)!.female)),
                DropdownMenuItem(
                    value: "other",
                    child: Text(AppLocalizations.of(context)!.other)),
              ],
            ),
            const SizedBox(height: 16),

            // Location
            Text(AppLocalizations.of(context)!.location,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _locationController,
              readOnly: false,
              decoration: InputDecoration(
                hintText: _isFetchingLocation
                    ? AppLocalizations.of(context)!.detectingCity
                    : AppLocalizations.of(context)!.enterYourCity,
                border: const OutlineInputBorder(),
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

            const SizedBox(height: 24),
            PrimaryButton(
                label: AppLocalizations.of(context)!.continueButton,
                onPressed: _saveProfile)
          ],
        ),
      ),
    );
  }
}
