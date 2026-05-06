import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/res/app_constants.dart';

class LanguageController extends GetxController
{
  @override
  Future<void> onInit() async {
    log("oninit calleed");
   filteredLanguage.assignAll(listOfLanguage);
   SharedPreferences prefs=await SharedPreferences.getInstance();
   String langName=prefs.getString(AppConstants.langName)??'English';
   log("lang code $langName");
   currenLanguage.value=langName;
   log("currenLanguage ${currenLanguage.value}");
    super.onInit();
  }
  void resetList()
  {
   query.value;
   filteredLanguage.assignAll(listOfLanguage);
  }
  //ui
  final RxList<String> listOfLanguage = [
    "Hindi",
    "English",
    "Gujarati",
    "Marathi",
    "Bengali",
    "Punjabi",
    "Tamil",
    "Telugu",
    "Malayalam",
    "Kannada",
    "Urdu",
    "Odia",
    "Assamese",
    "Sanskrit",
    "Nepali",
    "Bhojapuri",
  ].obs;
  final RxList<String> filteredLanguage = <String>[].obs;
  RxString query="".obs;
  RxString currenLanguage="".obs;

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

  Future<void> changeLanguage(String language) async {
    var langCode=languageMap[language];
    var locale = Locale(langCode!);
    Get.updateLocale(locale);
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(AppConstants.langCode, langCode);
    prefs.setString(AppConstants.langName, language);
  }

  void filterLanguages(String qry) {
    query.value=qry;
    if (query.value.isEmpty) {
      filteredLanguage.assignAll(listOfLanguage);
      log("total are ${filteredLanguage.length}");
    } else {
      filteredLanguage.assignAll(listOfLanguage.where((item) =>item.toLowerCase().contains(query.value.trim().toLowerCase())));
      log("total are ${filteredLanguage.length}");
      for(var i in filteredLanguage){
        log("item are $i}");
      }
    }
  }

}