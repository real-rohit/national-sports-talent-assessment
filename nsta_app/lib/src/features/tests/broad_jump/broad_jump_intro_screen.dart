import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';

class BroadJumpIntroScreen extends StatefulWidget {
  const BroadJumpIntroScreen({super.key});

  @override
  State<BroadJumpIntroScreen> createState() => _BroadJumpIntroScreenState();
}

class _BroadJumpIntroScreenState extends State<BroadJumpIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.newTest)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.directions_run,
                    size: 100, color: Colors.purple),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.standingBroadJump,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.broadJumpInstruction,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.qualityTested,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.lowerBodyExplosiveStrength,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
                label: AppLocalizations.of(context)!.startTest,
                onPressed: () {
                  // TODO: Navigate to actual test screen
                  Get.snackbar(
                    AppLocalizations.of(context)!.info,
                    AppLocalizations.of(context)!.testScreenComingSoon,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }),
            const SizedBox(height: 12),
            SecondaryButton(
                label: AppLocalizations.of(context)!.watchDemo,
                onPressed: () {
                  // TODO: Show demo video
                  Get.snackbar(
                    AppLocalizations.of(context)!.info,
                    AppLocalizations.of(context)!.demoVideoComingSoon,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
