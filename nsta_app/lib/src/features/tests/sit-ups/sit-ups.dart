import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart'; // Assuming you have this file

class SitUpsIntroScreen extends StatefulWidget {
  const SitUpsIntroScreen({super.key});

  @override
  State<SitUpsIntroScreen> createState() => _SitUpsIntroScreenState();
}

class _SitUpsIntroScreenState extends State<SitUpsIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: AppLocalizations.of(context)!.sitUpsTest,
        icon: Icons.arrow_back_sharp,
        onPressed: Navigator.of(context).pop,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.fitness_center,
                    size: 100, color: Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.sitUps,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.lieDownKneesBent,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
                label: AppLocalizations.of(context)!.startTest,
                onPressed: () =>
                    Navigator.of(context).pushNamed('/tests/camera')),
            const SizedBox(height: 12),
            SecondaryButton(
                label: AppLocalizations.of(context)!.watchDemo,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
