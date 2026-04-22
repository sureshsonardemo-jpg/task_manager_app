import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
class OnboardingController extends GetxController {

  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    currentPage.value = index;
    log("page changed triggered $index");
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn

      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void onSkip() {
  pageController.animateToPage(2,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn
  );
 }
}