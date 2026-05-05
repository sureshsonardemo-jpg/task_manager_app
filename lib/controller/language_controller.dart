import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController
{
  RxString currenLanguage="English".obs;
  final Map<String, String> languageMap = {
    "English": "en",
    "Hindi": "hi",
    "Gujarati": "gu",
    "Marathi": "mr",
    "Bengali": "bn",
    "Punjabi": "pa",
    "Tamil": "ta",
    "Telugu": "te",
    "Malayalam": "ml",
    "Kannada": "kn",
    "Urdu": "ur",
    "Odia": "or",
    "Assamese": "as",
    "Sanskrit": "sa",
    "Nepali": "ne",
    "Bhojpuri": "bho", // ⚠️ not officially supported in Flutter Locale
  };

  void changeLanguage(String language) {
    var langCode=languageMap[language];
    log("langcode $langCode");
    log("language $language");
    var locale = Locale(langCode!);
    Get.updateLocale(locale);
  }
}