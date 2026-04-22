import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/customTextStyles.dart'
    show CustomTextStyles;
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/custom_textfield.dart';

import '../../widget/custom_titles.dart' show CustomText;

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
   final controller=Get.find<AuthController>();
  static const route = "Sign-Up-Page";
  @override
  Widget build(BuildContext context) {
    double Scr_Height = MediaQuery.of(context).size.height;
    double Scr_Width = MediaQuery.of(context).size.width;
    var Figma_Height = 812;
    var Figma_width = 375;
    double H(double value) => (value / Figma_Height) * Scr_Height;
    double W(double value) => (value / Figma_width) * Scr_Width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: W(20)),
          child: Column(
            children: [
              //top bar
              SizedBox(height: H(39)),
              //logo image
              Container(
                margin: EdgeInsets.only(top: H(23.5)),
                height: H(100),
                width: H(100),
                child: Image.asset(
                  "assets/images/logo.png",
                  color: AppColors.purple,
                ),
              ),
              //title
              Container(
                margin: EdgeInsets.only(top: H(12)),
                height: H(36),
                child: CustomText().CustomTitle("Create Your Account", W(24)),
              ),
              //subtitle
              Container(
                margin: EdgeInsets.only(top: H(8)),
                height: H(44),
                child: CustomText().CustomDesc(
                  "Start organizing your tasks and boost your productivity today.",
                  W(14),
                    TextAlign.center,1.6
                ),
              ),
              //input fields
              Container(
                margin: EdgeInsets.only(top: H(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Name",
                            style: CustomTextStyles().MediumTextStyle().copyWith(
                              fontSize: H(12),
                              height: H(1.5),
                            ),
                          ),
                          SizedBox(height: H(4)),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: W(16),
                                vertical: H(13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: W(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Name",
                            style: CustomTextStyles().MediumTextStyle().copyWith(
                              fontSize: H(12),
                              height: H(1.5),
                            ),
                          ),
                          SizedBox(height: H(4)),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.TextfieldborderColor,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: W(16),
                                vertical: H(13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: H(12)),
                child: CustomTextField(
                  "Email Address",
                  "jacksparrow@gmail.com",
                  false,
                  false,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: H(12)),
                child: Obx(
                  () => CustomTextField("Password", "* * * * * * *", true, false),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: H(12)),
                child: Obx(
                  () => CustomTextField(
                    "Confirm Password",
                    "* * * * * * *",
                    true,
                    false,
                  ),
                ),
              ),
              //terms and policy
              Container(
                margin: EdgeInsets.only(top: H(12),right: W(44)),
                height: H(42),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Checkbox(value: controller.isChecked.value, onChanged: (value) =>controller.toggleCheckbox(),shape: RoundedRectangleBorder(side: BorderSide(width: 1.25)),)),
                    SizedBox(width: W(12)),
                    Expanded(
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          text: "By continuing you agree to our",
                          style: CustomTextStyles().RegularTextStyle().copyWith(
                            color: AppColors.textGrey,
                            fontSize: H(14),
                            letterSpacing: 0,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms",
                              style: CustomTextStyles()
                                  .RegularTextStyle()
                                  .copyWith(
                                    color: AppColors.purple,
                                    fontSize: H(14),
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 0,
                                    height: 1.5,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //login to navigate to terms and conditions screen
                                },
                            ),
                            TextSpan(
                              text: " & ",
                              style: CustomTextStyles()
                                  .RegularTextStyle()
                                  .copyWith(
                                color: AppColors.purple,
                                fontSize: H(14),
                                letterSpacing: 0,
                                height: 1.5,
                              )),TextSpan(
                              text: "Policy",
                              style: CustomTextStyles()
                                  .RegularTextStyle()
                                  .copyWith(
                                color: AppColors.purple,
                                fontSize: H(14),
                                decoration: TextDecoration.underline,
                                letterSpacing: 0,
                                height: 1.5,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //login to navigate to terms and conditions screen
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: double.infinity,margin: EdgeInsets.only(top: H(24)),
                child: CustomFlatButton(() {}, "Sign Up"),
              ),
              //continue with + social logins
              Container(
                margin: EdgeInsets.only(top: H(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/stroke.png"),
                    Text(
                      'Or continue with',
                      style: CustomTextStyles().MediumTextStyle().copyWith(
                        fontSize: H(14),
                        height: H(1.5),
                        color: AppColors.textGrey,
                      ),
                    ),
                    Image.asset("assets/images/stroke.png"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: H(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: H(12),vertical: W(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/google.png",height: H(28),),
                              Text(
                                "Google",
                                style: CustomTextStyles()
                                    .MediumTextStyle()
                                    .copyWith(
                                  fontSize: H(16),
                                  height: H(1.5),
                                  color: AppColors.textTitleBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: W(16)),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: W(12),vertical: H(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/apple.png",height: H(28),),
                              Text("Apple",
                                style: CustomTextStyles()
                                    .MediumTextStyle()
                                    .copyWith(
                                  fontSize: H(16),
                                  height: H(1.5),
                                  color: AppColors.textTitleBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        
                  ],
                ),
              ),
              //already have an acc
              Container( margin: EdgeInsets.only(top: H(48),bottom: H(8)),
                child: RichText(text: TextSpan(text: "Already have an account?",style:CustomTextStyles().RegularTextStyle().copyWith(color: AppColors.textGrey,fontSize: H(14)),children: [
                  TextSpan(text: " Sign In",style: CustomTextStyles().RegularTextStyle().copyWith(color: AppColors.purple,fontSize: H(14)),recognizer: TapGestureRecognizer()..onTap=(){
                    Get.offNamed(LoginScreen.route);
                  })
                ]),
                ),

              ),
              SizedBox(height: H(34)),
              
            ],
          ),
        ),
      ),
    );
  }
}
