
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app_services/app_services.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/app_textfields.dart';

import 'package:task_manager_app/view/widget/custom_flat_button.dart';


import '../../../services/auth_services.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final controller = Get.find<LoginController>();
  static const route = "Sign-Up-Page";
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();
  final AuthServices auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    var figmaHeight = 812;
    var figmaWidth = 375;
    double H(double value) => (value / figmaHeight) * scrHeight;
    double W(double value) => (value / figmaWidth) * scrWidth;
    controller.isChecked.value = false;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //top bar
                SizedBox(height: 44),
                //logo image
                Container(
                  margin: EdgeInsets.only(top: 18),
                  height:100,
                  width: 100,
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: AppColors.purple,
                  ),
                ),
                //title
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    "Create Your Account",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //subtitle
                Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "Start organizing your tasks and boost your productivity today.",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize:14,
                        color: AppColors.textGrey,
                        letterSpacing: 0,
                        height: 1.6,
                      ),
                      textAlign:TextAlign.center,
                    )
                ),
                //input fields
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppTextfields().TitleAndField(fNameController, "First Name", "jack"),
                      ),
                      SizedBox(width: W(10)),
                      Expanded(
                        child: AppTextfields().TitleAndField(lNameController, "Last Name", "Rob"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: H(12)),
                  child: AppTextfields().CustomTextField(
                    12,
                    "Email Address",
                    "jackrob@gmail.com",
                    false,
                    false,
                    emailController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: H(12)),
                  child: Obx(
                    () => AppTextfields().CustomTextField(
                      12,
                      "Password",
                      "* * * * * * *",
                      true,
                      false,
                      passController,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: H(12)),
                  child: Obx(
                    () => AppTextfields().CustomTextField(
                      12,
                      "Confirm Password",
                      "* * * * * * *",
                      true,
                      false,
                      cPassController,
                    ),
                  ),
                ),
                //terms and policy
                Container(
                  margin: EdgeInsets.only(top: H(12)),
                  height: H(42),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) =>
                              controller.isChecked.value = value!,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.25),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )
                      ),
                      SizedBox(width: W(12)),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            text: "By continuing you agree to our ",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(
                                  color: AppColors.textGrey,
                                  fontSize:14,
                                  letterSpacing: 0,
                                  height: 1.5,
                                ),
                            children: [
                              TextSpan(
                                text: "Terms",
                                style: Theme.of(context).textTheme.headlineSmall!
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
                                style: Theme.of(context).textTheme.headlineSmall!
                                    .copyWith(
                                      color: AppColors.purple,
                                      fontSize: H(14),
                                      letterSpacing: 0,
                                      height: 1.5,
                                    ),
                              ),
                              TextSpan(
                                text: "Policy",
                                style: Theme.of(context).textTheme.headlineSmall!
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
                // signup button
                Obx(() => Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: H(24)),
                    child: controller.isLoading.value
                        ? Center(
                        child: CircularProgressIndicator())
                        : CustomFlatButton(() {
                            if (!controller.isChecked.value) {
                              AppServices.showSnackBar(SnackBarType.info, "Agree Terms & Policies Before Registration",);
                            }else{
                              if (_formKey.currentState!.validate() &&
                                  passController.text == cPassController.text) {
                                auth.signupUser(
                                  fNameController.text,
                                  lNameController.text,
                                  emailController.text,
                                  passController.text,
                                );
                              }
                            }
                          }, "Sign Up"),
                  ),
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
                Container(
                  margin: EdgeInsets.only(top: H(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.deactiveDot,
                              side: BorderSide(color: AppColors.deactiveDot),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              AuthServices().continueWithGoogle();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/google.png",
                                    height: 28,
                                  ),
                                  Text(
                                    "Google",
                                    style:Theme.of(context).textTheme.bodyLarge!
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
                      SizedBox(width: W(16)),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.deactiveDot,
                            side: BorderSide(color: AppColors.deactiveDot),
                            alignment: Alignment.center,
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/apple.png",
                                  height: 28,
                                ),
                                Text(
                                  "Apple",
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
                //already have an acc
                Container(
                  margin: EdgeInsets.only(top: H(48), bottom: H(8)),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.textGrey,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: AppColors.purple,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed(LoginScreen.route);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
