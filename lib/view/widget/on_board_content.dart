import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/on_boarding_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/customTextStyles.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/custom_titles.dart';

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
    var Scr_Height = MediaQuery.of(context).size.height;
    var Scr_Width = MediaQuery.of(context).size.width;

    var Figma_Height = 812;
    var Figma_width = 375;

    double H(double value) => (value / Figma_Height) * Scr_Height;
    double W(double value) => (value / Figma_width) * Scr_Width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(height: H(44)),
          //upperbar(back btn + skip btn)
          Container(
            height: H(44),
            width: W(335),
            margin: EdgeInsets.only(top: H(18), left: W(20), right: W(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //back button
                Obx(
                  () => controller.currentPage > 0
                      ? InkWell(
                          onTap: () => controller.previousPage(),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromRGBO(229, 226, 227, 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_sharp,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
                //skip button
                Container(
                  margin: EdgeInsets.symmetric(vertical: H(8.5)),
                  child: InkWell(
                    child: InkWell(
                      onTap: () => controller.onSkip(),
                      child: Text(
                        "Skip",
                        style: CustomTextStyles().RegularTextStyle().copyWith(
                          fontSize: H(18), //compromised calc
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: H(51)),
          //image
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(image, height: H(335), width: W(335)),
          ),
          SizedBox(height: H(40)),
          //dots+title+sub+btn
          Container(
            margin: EdgeInsets.only(left: W(20), right: W(20), bottom: H(20)),
            height: H(240),
            width: W(335),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //dots
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.only(right: W(6)),
                        height: H(8),
                        width: index == controller.currentPage.value
                            ? W(48)
                            : W(20),
                        decoration: BoxDecoration(
                          color: index == controller.currentPage.value
                              ? AppColors.activeDot
                              : AppColors.deactiveDot,
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: H(30)), //compromised 32
                //title + subtitle
                Container(
                  height: H(128),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: W(20), right: W(20)),
                        height: H(72),
                        child: Center(
                          child: 
                          CustomText().CustomTitle(title, W(24)),
                        ),
                      ),
                      SizedBox(height: W(8)),
                      Container(
                        margin: EdgeInsets.only(left: W(20), right: W(20)),
                        height: H(48),
                        child: Center(
                          child: CustomText().CustomDesc(description,W(16),TextAlign.center,1.5),

                        ),
                      ),
                    ],
                  ),
                ),
                //button
                Container(
                  margin: EdgeInsets.only(
                    left: W(20),
                    right: W(20),
                    top: H(24),
                    bottom: H(6),
                  ),
                  width: W(335),
                  height: H(44),
                  child: Obx(
                    () => CustomFlatButton(
                      () {
                        if (controller.currentPage < 2) {
                          controller.nextPage();
                        } else {
                          Get.offNamed(LoginScreen.route);
                        }
                      },
                      controller.currentPage < 2 ? "Next" : "Let's Get Started",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
