import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService extends GetxController {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  final _storage = GetStorage();
  final _locale = const Locale('en', '').obs;

  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage = _storage.read('language_code');
    if (savedLanguage != null) {
      _locale.value = Locale(savedLanguage, '');
    }
  }

  void changeLanguage(String languageCode) {
    _locale.value = Locale(languageCode, '');
    _storage.write('language_code', languageCode);
    Get.updateLocale(_locale.value);
  }

  bool get isEnglish => _locale.value.languageCode == 'en';
  bool get isHindi => _locale.value.languageCode == 'hi';
}
