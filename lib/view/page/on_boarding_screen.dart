import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/on_boarding_controller.dart';
import 'package:task_manager_app/data_models/on_board_model.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/widget/on_board_content.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const route = "/On-Boarding-Screen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardModel> onboardingList = [
    OnBoardModel(
      image: "assets/images/boarding_image1.png",
      title: "Organize Your Tasks in One Place",
      description: "Plan your day, manage your to-do lists, and keep track of everything that matters.",
    ),
    OnBoardModel(
      image: "assets/images/boarding_image2.png",
      title: "Plan Smarter and Stay Focused",
      description: "Break big goals into simple tasks and manage your time more effectively.",
    ),
    OnBoardModel(
      image: "assets/images/boarding_image3.png",
      title: "Build Productive Habits Every Day",
      description: "Track progress, complete tasks, and celebrate every achievement.",
    ),
  ];
  final controller=Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body:PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller:controller.pageController,
          itemCount: onboardingList.length,
          onPageChanged: (index) => controller.onPageChanged(index),
          itemBuilder: (context, index){
            final item=onboardingList[index];
            return OnBoardContent(title: item.title,description: item.description,image: item.image,index: index);
          }
      ),
    );
  }

}
