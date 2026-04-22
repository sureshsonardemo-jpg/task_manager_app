import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route="/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1),() {
      Get.offNamed(OnBoardingScreen.route);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Center(
        child: Image.asset("assets/images/main_logo.png"),
      ),

    );
  }
}
