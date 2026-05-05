import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/page/auth/forgot_password_screen.dart';
import 'package:task_manager_app/view/page/auth/signup_screen.dart';
import 'package:task_manager_app/view/widget/app_textfields.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/custom_titles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const route = "Login_scr";
  final loginController = Get.put(LoginController());
  final AuthServices auth=AuthServices();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    var figmaHeight = 812;
    var figmaWidth = 375;
    double H(double value) => (value / figmaHeight) * scrHeight;
    double W(double value) => (value / figmaWidth) * scrWidth;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(height: 44),
            Container(
              margin: EdgeInsets.only(top: 18),
              height:100,
              width: 100,
              child: Image.asset(
                "assets/images/logo.png",
                color: AppColors.purple,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 36,
              child: CustomText().CustomTitle("Welcome Back!",24),
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
              child: AppTextfields().CustomTextField(
                14,
                "Email Address",
                "e.g. jackrob187@gmail.com",
                false,
                false,
                emailController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(12)),
              child: Obx(
                () =>
                    AppTextfields().CustomTextField(14,"Password", "* * * * * * *", true, false,passController),
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
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: W(24)),
              width: W(335),
              height: H(44),
              child: Obx(() =>  loginController.isLoading.value ?const Center(child: CircularProgressIndicator()):CustomFlatButton(() {
                  if(emailController.text.isNotEmpty && passController.text.isNotEmpty) {
                    auth.loginUser(emailController.text, passController.text);
                  }
                }, "Log In"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: H(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/stroke.png"),
                  Text(
                    'Or continue with',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: H(14),
                      height: H(1.5),
                      color: AppColors.textGrey,
                    ),
                  ),
                  Image.asset("assets/images/stroke.png"),
                ],
              ),
            ),
            //google apple logins
            Container(
              margin: EdgeInsets.only(top: H(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.deactiveDot,
                            side: BorderSide(color: AppColors.deactiveDot),
                            alignment: Alignment.center,
                          ),
                        onPressed: () {
                          AuthServices().continueWithGoogle();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/google.png",height:28,),
                              Text(
                                "Google",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontSize: 16,
                                      color: AppColors.textTitleBlack,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),

                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.deactiveDot,
                        side: BorderSide(color: AppColors.deactiveDot),
                        alignment: Alignment.center,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/apple.png",height: 28),
                            Text("Apple",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                fontSize: 16,
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
            Spacer(),
            Container(margin:  EdgeInsets.only(bottom: 34),alignment: Alignment.center,
              child: RichText(text: TextSpan(text: "Don’t have an account?",style:Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.textGrey,fontSize: H(14)),children: [
                TextSpan(text: " Sign Up",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.purple,fontSize: H(14)),recognizer: TapGestureRecognizer()..onTap=(){
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
