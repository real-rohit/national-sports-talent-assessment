import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsta_app/src/core/services/auth_service.dart';
import 'package:nsta_app/src/core/services/language_service.dart';
import 'package:nsta_app/src/features/homescreen/change_Pass.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';
import 'package:nsta_app/src/shared/widgets/sections.dart';
import 'edit_details_screen.dart';
// import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final languageService = Get.find<LanguageService>();

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 16;

    return Scaffold(
      appBar: CustomAppBar3(title: AppLocalizations.of(context)!.settings),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            SectionCard(
              title: AppLocalizations.of(context)!.account,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: Text(AppLocalizations.of(context)!.editDetails),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditDetailsScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(AppLocalizations.of(context)!.changePassword),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete_forever),
                    title: Text(
                      AppLocalizations.of(context)!.deleteAccount,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () => _showDeleteAccountDialog(),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(
                      AppLocalizations.of(context)!.logout,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                    onTap: () => AuthService.signOut(),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: AppLocalizations.of(context)!.appPreferences,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 9),
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.language),
                    trailing: _buildCreativeLanguageSwitcher(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreativeLanguageSwitcher() {
    bool isEnglish = languageService.isEnglish;

    return Container(
      width: 120,
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _flagButton(
            label: '🇬🇧',
            selected: isEnglish,
            onTap: () {
              languageService.changeLanguage('en');
              setState(() {});
            },
          ),
          _flagButton(
            label: '🇮🇳',
            selected: !isEnglish,
            onTap: () {
              languageService.changeLanguage('hi');
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _flagButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(label, style: const TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteAccountRequest),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.fullName,
                  ),
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!.enterYourName
                      : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                  ),
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!.enterYourEmail
                      : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.phoneNumber,
                  ),
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!.enterYourNumber
                      : null,
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.reason,
                  ),
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!.enterReason
                      : null,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.submit),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('deleteRequest')
                    .doc(uid)
                    .set({
                  'name': nameController.text.trim(),
                  'email': emailController.text.trim(),
                  'phone': phoneController.text.trim(),
                  'reason': reasonController.text.trim(),
                  'timestamp': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .deleteRequestSubmitted)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
