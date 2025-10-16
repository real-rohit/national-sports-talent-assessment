import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nsta_app/src/core/services/language_service.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Get.find<LanguageService>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => languageService.changeLanguage('en'),
          child: Text(
            AppLocalizations.of(context)!.english,
            style: TextStyle(
              fontWeight: languageService.isEnglish
                  ? FontWeight.w700
                  : FontWeight.normal,
              color: languageService.isEnglish ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text('|'),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => languageService.changeLanguage('hi'),
          child: Text(
            AppLocalizations.of(context)!.hindi,
            style: TextStyle(
              fontWeight:
                  languageService.isHindi ? FontWeight.w700 : FontWeight.normal,
              color: languageService.isHindi ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
