import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart'; // Assuming you have this file

class HeightWeightIntroScreen extends StatefulWidget {
  const HeightWeightIntroScreen({super.key});

  @override
  State<HeightWeightIntroScreen> createState() =>
      _HeightWeightIntroScreenState();
}

class _HeightWeightIntroScreenState extends State<HeightWeightIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: AppLocalizations.of(context)!.heightWeightTest,
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
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.straighten,
                    size: 100, color: Colors.purple),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.heightWeight,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.enterHeightWeightAccurately,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            // TODO: This button should navigate to a data entry form, not the camera.
            PrimaryButton(
                label: AppLocalizations.of(context)!.enterData,
                onPressed: () {
                  // Navigator.of(context).pushNamed('/tests/data-entry-form');
                }),
            const SizedBox(height: 12),
            SecondaryButton(
                label: AppLocalizations.of(context)!.howToMeasure,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
