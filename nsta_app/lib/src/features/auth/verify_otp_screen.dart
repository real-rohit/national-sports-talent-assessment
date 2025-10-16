import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nsta_app/src/core/services/auth_service.dart';
// import '../../../src/services/auth_service.dart';
import '../../shared/widgets/buttons.dart';
import '../profile/create_profile_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const VerifyOtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otp = TextEditingController();
  bool _loading = false;

  void _verify() async {
    if (_otp.text.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.enterOtpError,
          snackPosition: SnackPosition.BOTTOM);
    }
    setState(() => _loading = true);
    await AuthService.verifyOtp(
      verificationId: widget.verificationId,
      smsCode: _otp.text.trim(),
      onSuccess: () {
        setState(() => _loading = false);
        Get.offAll(() => const CreateProfileScreen());
      },
      onError: (msg) {
        setState(() => _loading = false);
        Get.snackbar(AppLocalizations.of(context)!.error, msg,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.verifyPhone(widget.phoneNumber))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(
              controller: _otp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterOtp)),
          const SizedBox(height: 16),
          PrimaryButton(
            label: _loading
                ? AppLocalizations.of(context)!.verifying
                : AppLocalizations.of(context)!.verifyOtp,
            onPressed: _loading ? null : _verify,
          ),
        ]),
      ),
    );
  }
}
