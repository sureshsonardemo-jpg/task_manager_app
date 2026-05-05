import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/controller/on_boarding_controller.dart';
import 'package:task_manager_app/res/app_constants.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/upper_bar/common_upper_bar.dart';

class OnBoardContent extends StatelessWidget {
  String title, description, image;
  int index;
  OnBoardContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.index,
  });

  final controller = Get.find<OnboardingController>();
  @override
  Widget build(BuildContext context) {
    var scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(height: 44),
          //upper bar(back btn + skip btn)
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Obx(() =>CommonUpperBar(onBack:controller.currentPage > 0?()=>  controller.previousPage():null,
            trailing:InkWell(
              onTap: () => controller.onSkip(),
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.textGrey,
                  fontSize:18
                ),textAlign: TextAlign.center,
              ),
            ))),
          ),
          Spacer(flex: 5,),
          //image
          Container(margin: EdgeInsets.only(left: 20,right: 20),
              height: scrHeight*0.43,
              child: Image.asset(image, width:double.infinity )),
          Spacer(flex: 8),
          //title+sub+btn
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            height: scrHeight*0.16,
            width:double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.textGrey,
                      fontSize: 16
                    ),
                    textAlign:TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          //button
          Container(
            margin: EdgeInsets.only(top: 24, bottom: 40,left: 20,right: 20),
            width: double.infinity,
            height: 50,
            child: Obx(
                  () => CustomFlatButton(
                    () async {
                  if (controller.currentPage < 2) {
                    controller.nextPage();
                  } else {
                    SharedPreferences prefs=  await SharedPreferences.getInstance();
                    await prefs.setBool(AppConstants.hasSeenIntro, true);
                    Get.offNamed(LoginScreen.route);
                  }
                },
                controller.currentPage < 2 ? "Next" : "Let's Get Started",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
