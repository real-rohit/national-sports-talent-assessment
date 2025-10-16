import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/firebase_options.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/core/theme/app_theme.dart';
import 'package:nsta_app/src/core/services/language_service.dart';
import 'package:nsta_app/src/features/homescreen/splash_screen.dart';
// import 'package:nsta_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  // Initialize language service
  Get.put(LanguageService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageService>(
      builder: (languageService) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NSTA Athlete',
          theme: AppTheme.theme(),
          home: SplashScreen(),
          locale: languageService.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('hi', ''), // Hindi
          ],
        );
      },
    );
  }
}
