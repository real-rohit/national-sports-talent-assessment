import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/core/services/auth_service.dart';
import 'package:nsta_app/src/features/auth/signup_screen.dart';
import 'package:nsta_app/src/features/homescreen/dashboard_screen.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/language_switcher.dart';
import '../profile/create_profile_screen.dart';
import 'verify_otp_screen.dart';

enum AuthMode { phone, email }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _mode = AuthMode.phone;
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  void _show(String msg) =>
      Get.snackbar(AppLocalizations.of(context)!.info, msg,
          snackPosition: SnackPosition.BOTTOM);

  Future<void> _onSuccess() async {
    final box = GetStorage();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final userId = box.read('userId');

    print("User Id in the success function: $userId");

    final doc = await _firestore.collection('users').doc(userId).get();

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
  }

  Future<void> _handlePhone() async {
    if (_phone.text.trim().isEmpty)
      return _show(AppLocalizations.of(context)!.enterPhoneCountryCode);
    setState(() => _loading = true);
    await AuthService.sendOtp(
      phone: _phone.text.trim(),
      onCodeSent: (id) {
        setState(() => _loading = false);
        Get.to(() => VerifyOtpScreen(
            verificationId: id, phoneNumber: _phone.text.trim()));
      },
      onError: (msg) {
        setState(() => _loading = false);
        _show(msg);
      },
      onAutoVerified: () {
        setState(() => _loading = false);
        _onSuccess();
      },
    );
  }

  Future<void> _handleEmail() async {
    final box = GetStorage();
    if (_email.text.isEmpty || _pass.text.isEmpty) {
      return _show(AppLocalizations.of(context)!.enterEmailPassword);
    }
    setState(() => _loading = true);

    await AuthService.signInWithEmail(
      email: _email.text.trim(),
      password: _pass.text,
      onSuccess: () async {
        try {
          final query = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: _email.text.trim())
              .limit(1)
              .get();

          if (query.docs.isNotEmpty) {
            final userDoc = query.docs.first;
            final userId = userDoc['userId'] ?? '';

            box.write('userId', userId);
            print('User id is stored $userId');
          }

          setState(() {
            _loading = false;
            _onSuccess();
          });
        } catch (e) {
          setState(() => _loading = false);
          _show(AppLocalizations.of(context)!.failedToRetrieveUserData);
        }
      },
      onError: (msg) {
        setState(() => _loading = false);
        _show(msg);
      },
    );
  }

  String _countryCode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LanguageSwitcher(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.125),
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.sports_martial_arts,
                        size: 60, color: Colors.green),
                  ),
                  const SizedBox(height: 24),
                  Text(AppLocalizations.of(context)!.discoverYourPotential,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ChoiceChip(
                        label: Text(AppLocalizations.of(context)!.phone),
                        selected: _mode == AuthMode.phone,
                        onSelected: (_) =>
                            setState(() => _mode = AuthMode.phone)),
                    const SizedBox(width: 12),
                    ChoiceChip(
                        label: Text(AppLocalizations.of(context)!.email),
                        selected: _mode == AuthMode.email,
                        onSelected: (_) =>
                            setState(() => _mode = AuthMode.email)),
                  ]),
                  const SizedBox(height: 12),
                  if (_mode == AuthMode.phone) ...[
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CountryCodePicker(
                            onChanged: (code) => setState(
                                () => _countryCode = code.dialCode ?? '+91'),
                            initialSelection: 'IN',
                            favorite: const ['+91', 'IN'],
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
                              hintText:
                                  AppLocalizations.of(context)!.phoneNumberHint,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    PrimaryButton(
                      label: _loading
                          ? AppLocalizations.of(context)!.sending
                          : AppLocalizations.of(context)!.sendOtp,
                      onPressed: _loading ? null : _handlePhone,
                    ),
                  ] else ...[
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.emailHint),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.passwordHint),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    PrimaryButton(
                      label: _loading
                          ? AppLocalizations.of(context)!.pleaseWait
                          : AppLocalizations.of(context)!.signInRegister,
                      onPressed: _loading ? null : _handleEmail,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Center(
                      child: InkWell(
                    onTap: () => {Get.to(() => const SignUpScreen())},
                    child: Text(
                        AppLocalizations.of(context)!.newHereCreateAccount,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  )),
                ]),
          ),
        ),
      ),
    );
  }
}
