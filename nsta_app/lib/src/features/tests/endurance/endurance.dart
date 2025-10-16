import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart'; // Assuming you have this file

class EnduranceRunIntroScreen extends StatefulWidget {
  const EnduranceRunIntroScreen({super.key});

  @override
  State<EnduranceRunIntroScreen> createState() =>
      _EnduranceRunIntroScreenState();
}

class _EnduranceRunIntroScreenState extends State<EnduranceRunIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: AppLocalizations.of(context)!.enduranceTest,
        icon: Icons.arrow_back_outlined,
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
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.directions_run_outlined,
                    size: 100, color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.enduranceRun,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.runSetDistance,
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
