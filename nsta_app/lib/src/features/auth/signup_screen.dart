import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/core/services/auth_service.dart';
import 'package:nsta_app/src/features/auth/login_screen.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';
import '../../shared/widgets/buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String _countryCode = '+91'; // default to India (auto-updated)

  bool _loading = false;

  final box = GetStorage();

  void _show(String msg) =>
      Get.snackbar(AppLocalizations.of(context)!.info, msg,
          snackPosition: SnackPosition.BOTTOM);

  void _handleSignUp() async {
    if (_name.text.isEmpty ||
        _phone.text.isEmpty ||
        _email.text.isEmpty ||
        _pass.text.isEmpty) {
      return _show(AppLocalizations.of(context)!.pleaseFillAllFields);
    }

    setState(() => _loading = true);
    final phoneWithCode = '$_countryCode${_phone.text.trim()}';

    await AuthService.signUpWithEmail(
      name: _name.text.trim(),
      phone: phoneWithCode,
      email: _email.text.trim(),
      password: _pass.text,
      onSuccess: () {
        final uid = AuthService.currentUser?.uid ?? '';
        box.write('userId', uid);
        setState(() => _loading = false);
        Get.offAll(() => LoginScreen());
      },
      onError: (msg) {
        setState(() => _loading = false);
        _show(msg);
      },
    );
  }

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      );

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.signup),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _fieldLabel(AppLocalizations.of(context)!.fullName),
            TextField(controller: _name),
            const SizedBox(height: 16),
            _fieldLabel(AppLocalizations.of(context)!.phoneNumber),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CountryCodePicker(
                    onChanged: (code) =>
                        setState(() => _countryCode = code.dialCode ?? '+91'),
                    initialSelection: 'IN', // ✅ auto uses device locale
                    favorite: const ['+91', 'IN'], // top of list
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phoneNumberHint,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _fieldLabel(AppLocalizations.of(context)!.emailAddress),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _fieldLabel(AppLocalizations.of(context)!.password),
            TextField(
              decoration: InputDecoration(
                  suffix: InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                  color: Colors.grey,
                ),
              )),
              controller: _pass,
              obscureText: isObscure,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: _loading
                  ? AppLocalizations.of(context)!.pleaseWait
                  : AppLocalizations.of(context)!.createAccount,
              onPressed: _loading ? null : _handleSignUp,
            ),
          ],
        ),
      ),
    );
  }
}
