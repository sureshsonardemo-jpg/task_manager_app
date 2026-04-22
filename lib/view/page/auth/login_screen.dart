import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/auth/forgot_password_screen.dart';
import 'package:task_manager_app/view/page/auth/signup_screen.dart';
import 'package:task_manager_app/view/page/main/home_screen.dart';
import 'package:task_manager_app/view/widget/customTextStyles.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/custom_textfield.dart';
import 'package:task_manager_app/view/widget/custom_titles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const route = "Login_scr";
  final controller = Get.put(AuthController());
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: H(20)),
        child: Column(
          children: [
            Container(height: H(44),),
            Container(
              margin: EdgeInsets.only(top: H(18)),
              height: H(100),
              width: H(100),
              child: Image.asset(
                "assets/images/logo.png",
                color: AppColors.purple,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(12)),
              height: H(36),
              child: CustomText().CustomTitle("Welcome Back!", W(24)),
            ),
            Container(
              margin: EdgeInsets.only(top: H(12)),
              height: H(44),
              child: CustomText().CustomDesc(
                "Sign in to continue managing your tasks and stay organized.",
                W(14),
                TextAlign.center,1.6
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(24)),
              height: H(73),
              child: CustomTextField(
                "Email Address",
                "e.g. jackrob187@gmail.com",
                false,
                false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(12)),
              height: H(73),
              child: Obx(
                () =>
                    CustomTextField("Password", "* * * * * * *", true, false),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(16), left: H(210)),
              child: InkWell(
                onTap: () {
                  Get.toNamed(ForgotPasswordScreen.route);
                  },
                child: Text(
                  "Forgot password?",
                  style: CustomTextStyles().MediumTextStyle().copyWith(
                    fontSize: W(14),
                    height: 1.5,
                    color: AppColors.purple,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: W(24)),
              width: W(335),
              height: H(44),
              child: CustomFlatButton(() {
                //logic of login
                Get.offAllNamed(HomeScreen.route);
              }, "Log In"),
            ),
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
            //don't have acc
            Container(margin:  EdgeInsets.only(top: H(84),bottom: H(6)),
              child: RichText(text: TextSpan(text: "Don’t have an account?",style:CustomTextStyles().RegularTextStyle().copyWith(color: AppColors.textGrey,fontSize: H(14)),children: [
                TextSpan(text: " Sign Up",style: CustomTextStyles().RegularTextStyle().copyWith(color: AppColors.purple,fontSize: H(14)),recognizer: TapGestureRecognizer()..onTap=(){
                  Get.toNamed(SignupScreen.route);
                })
              ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
