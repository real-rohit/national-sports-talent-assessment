import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/core/theme/app_theme.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';

class EditDetailsScreen extends StatefulWidget {
  const EditDetailsScreen({super.key});

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final sportsCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final userIdCtrl = TextEditingController();

  String? genderValue; // Male/Female/Other

  bool isLoading = true;
  bool isSaving = false;
  bool _isFetchingLocation = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String uid = "";

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    uid = box.read('userId');
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) return;

      final data = doc.data() ?? {};

      setState(() {
        userIdCtrl.text = uid;
        nameCtrl.text = (data['name'] ?? '').toString();
        emailCtrl.text = (data['email'] ?? '').toString();
        phoneCtrl.text = (data['phone'] ?? '').toString();
        ageCtrl.text = (data['age'] ?? '').toString();
        heightCtrl.text = (data['height'] ?? '').toString();
        weightCtrl.text = (data['weight'] ?? '').toString();
        sportsCtrl.text = (data['sport'] ?? '').toString();
        final genderFromDb = (data['gender'] ?? '').toString().toLowerCase();

        switch (genderFromDb) {
          case 'male':
            genderValue = 'Male';
            break;
          case 'female':
            genderValue = 'Female';
            break;
          case 'other':
            genderValue = 'Other';
            break;
          default:
            genderValue = null;
        }

        final location = (data['location'] ?? '').toString();
        if (location.isNotEmpty) {
          locationCtrl.text = location;
        } else {
          _fetchUserCityAndSave();
        }
      });
    } catch (e) {
      debugPrint("Error loading user data: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .failedToLoadData(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  /// Fetch current city using Geolocator and save to Firestore
  Future<void> _fetchUserCityAndSave() async {
    setState(() => _isFetchingLocation = true);

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        locationCtrl.text = AppLocalizations.of(context)!.permissionDenied;
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

        setState(() {
          locationCtrl.text = city;
        });

        // Save location to Firestore
        // final uid = _auth.currentUser!.uid;

        await _firestore.collection('users').doc(uid).set({
          'location': city,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } else {
        setState(
            () => locationCtrl.text = AppLocalizations.of(context)!.unknown);
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
      setState(() => locationCtrl.text =
          AppLocalizations.of(context)!.errorFetchingLocation);
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 16;

    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: CustomAppBar2(
          title: AppLocalizations.of(context)!.editDetails,
          icon: Icons.arrow_back_outlined,
          onPressed: () => Get.back()),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(pad),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildLabel(AppLocalizations.of(context)!.name),
                      _buildField(nameCtrl, AppLocalizations.of(context)!.name,
                          validator: (v) => v == null || v.isEmpty
                              ? AppLocalizations.of(context)!.nameCannotBeEmpty
                              : null),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.userId),
                      TextFormField(
                        controller: userIdCtrl,
                        readOnly: true, // cannot edit
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 230, 230, 230),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.email),
                      _buildField(
                          emailCtrl, AppLocalizations.of(context)!.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v != null && v.contains('@')
                              ? null
                              : AppLocalizations.of(context)!.enterValidEmail),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.phoneNumber),
                      _buildField(
                          phoneCtrl, AppLocalizations.of(context)!.phoneNumber,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v != null && v.length >= 10
                              ? null
                              : AppLocalizations.of(context)!
                                  .enterValidPhoneNumber),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.age),
                      _buildField(ageCtrl, AppLocalizations.of(context)!.age,
                          keyboardType: TextInputType.number,
                          validator: (v) => v != null && int.tryParse(v) != null
                              ? null
                              : AppLocalizations.of(context)!.enterValidAge),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.height),
                      _buildField(
                          heightCtrl, AppLocalizations.of(context)!.heightCm,
                          keyboardType: TextInputType.number,
                          validator: (v) => v != null &&
                                  double.tryParse(v) != null
                              ? null
                              : AppLocalizations.of(context)!.enterValidHeight),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.weight),
                      _buildField(
                          weightCtrl, AppLocalizations.of(context)!.weightKg,
                          keyboardType: TextInputType.number,
                          validator: (v) => v != null &&
                                  double.tryParse(v) != null
                              ? null
                              : AppLocalizations.of(context)!.enterValidWeight),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.sport),
                      _buildField(
                          sportsCtrl, AppLocalizations.of(context)!.sports,
                          validator: (v) => v == null || v.isEmpty
                              ? AppLocalizations.of(context)!
                                  .sportsCannotBeEmpty
                              : null),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.gender),
                      DropdownButtonFormField<String>(
                        value: genderValue,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'Male',
                              child: Text(AppLocalizations.of(context)!.male)),
                          DropdownMenuItem(
                              value: 'Female',
                              child:
                                  Text(AppLocalizations.of(context)!.female)),
                          DropdownMenuItem(
                              value: 'Other',
                              child: Text(AppLocalizations.of(context)!.other)),
                        ],
                        onChanged: (v) {
                          setState(() => genderValue = v);
                        },
                        validator: (v) => v == null || v.isEmpty
                            ? AppLocalizations.of(context)!.pleaseSelectGender
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildLabel(AppLocalizations.of(context)!.location),
                      TextFormField(
                        controller: locationCtrl,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: _isFetchingLocation
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.location_searching),
                                  onPressed: _fetchUserCityAndSave,
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                          label: AppLocalizations.of(context)!.save,
                          onPressed: isSaving ? null : _saveDetails)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLabel(String label) => Text(label,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _buildField(TextEditingController ctrl, String label,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  /// Save all fields to Firestore
  Future<void> _saveDetails() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    try {
      // final uid = _auth.currentUser!.uid;

      await _firestore.collection('users').doc(uid).set({
        'userId': uid,
        'name': nameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'age': ageCtrl.text.trim(),
        'height': heightCtrl.text.trim(),
        'weight': weightCtrl.text.trim(),
        'sport': sportsCtrl.text.trim(),
        'gender': genderValue ?? '',
        'location': locationCtrl.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.detailsUpdatedSuccessfully)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error saving user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalizations.of(context)!.failedToSaveData(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }
}
