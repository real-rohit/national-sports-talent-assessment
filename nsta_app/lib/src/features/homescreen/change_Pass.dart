import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsta_app/l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.changePassword)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.oldPassword,
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty
                    ? AppLocalizations.of(context)!.enterOldPassword
                    : null,
              ),
              TextFormField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.newPassword,
                ),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? AppLocalizations.of(context)!.passwordTooShort
                    : null,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                ),
                obscureText: true,
                validator: (value) => value != newPasswordController.text
                    ? AppLocalizations.of(context)!.passwordsDoNotMatch
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _changePassword,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(AppLocalizations.of(context)!.updatePassword),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser!;
    final cred = EmailAuthProvider.credential(
        email: user.email!, password: oldPasswordController.text.trim());

    try {
      // Reauthenticate
      await user.reauthenticateWithCredential(cred);
      // Update password
      await user.updatePassword(newPasswordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.passwordUpdated)));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
    } finally {
      setState(() => isLoading = false);
    }
  }
}
