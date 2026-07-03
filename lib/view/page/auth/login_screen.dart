import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/page/auth/forgot_password_screen.dart';
import 'package:task_manager_app/view/page/auth/signup_screen.dart';
import 'package:task_manager_app/view/responsive.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body:Responsive.isDesktop(context)?Center(
        child: ConstrainedBox(constraints:BoxConstraints(maxHeight: 900,maxWidth: 400),
          child: pageContent(context),),
      )
          :pageContent(context)
    );
  }

  Widget pageContent(BuildContext context){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 44),
            //logo
            Container(
              margin: EdgeInsets.only(top: 18),
              height:100,
              width: 100,
              child: Image.asset(
                "assets/images/logo.png",
                color: AppColors.purple,
              ),
            ),
            //welocme back
            Container(
              margin: EdgeInsets.only(top: 12),
              child: CustomText().CustomTitle("Welcome Back!",24),
            ),
            //desc
            Container(
              margin: EdgeInsets.only(top: 8),
              child: CustomText().CustomDesc(
                  "Sign in to continue managing your tasks and stay organized.",
                  14,
                  TextAlign.center,1.6
              ),
            ),
            //input fields
            Container(
              margin: EdgeInsets.only(top: 24),
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
              margin: EdgeInsets.only(top: 12),
              child: Obx(
                    () =>
                    AppTextfields().CustomTextField(14,"Password", "* * * * * * *", true, false,passController),
              ),
            ),
            //forgot pass
            Container(
              margin: EdgeInsets.only(top: 16,),
              alignment: Alignment.centerRight,
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
            //loginBtn
            Container(
              margin: EdgeInsets.only(top: 24),
              width: double.infinity,
              height:48,
              child: Obx(() =>  loginController.isLoading.value ?const Center(child: CircularProgressIndicator()):CustomFlatButton(() {
                if(emailController.text.isNotEmpty && passController.text.isNotEmpty) {
                  auth.loginUser(emailController.text, passController.text);
                }
              }, "Log In"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/stroke.png"),
                  Text(
                    'Or continue with',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.textGrey,
                    ),
                  ),
                  Image.asset("assets/images/stroke.png"),
                ],
              ),
            ),
            //google apple logins
            Container(
              margin: EdgeInsets.only(top: 24),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            //don't have acc spacer
            SizedBox(height: 85,),
            Container(margin:  EdgeInsets.only(bottom: 30),
              alignment: Alignment.bottomCenter,
              child: RichText(text: TextSpan(text: "Don’t have an account?",style:Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.textGrey,fontSize: 14),children: [
                TextSpan(text: " Sign Up",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.purple,fontSize: 14),recognizer: TapGestureRecognizer()..onTap=(){
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
