import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart'; // Assuming you have this file

class ShuttleRunIntroScreen extends StatefulWidget {
  const ShuttleRunIntroScreen({super.key});

  @override
  State<ShuttleRunIntroScreen> createState() => _ShuttleRunIntroScreenState();
}

class _ShuttleRunIntroScreenState extends State<ShuttleRunIntroScreen> {
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
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.directions_run,
                    size: 100, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.shuttleRun,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.runBetweenMarkedPoints,
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
