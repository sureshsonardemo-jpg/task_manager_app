
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/custom_titles.dart';

import '../../widget/app_textfields.dart' show AppTextfields;

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  static const String route = "Forgot-pass-scr";
  final emailController = TextEditingController();
  final loginController=Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //icon
              InkWell(
                onTap: () {
                  Get.offNamed(LoginScreen.route);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color.fromRGBO(229, 226, 227, 1)),
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
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: CustomText().CustomTitle("Forgot Password", 24),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: CustomText().CustomDesc(
                  "Enter your registered email below to receive password reset instructions.",
                  14,
                  TextAlign.start,
                  1.6,
                ),
              ),
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
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                width: double.infinity,
                height: 48,
                child: Obx(() => loginController.isLoading.value?const Center(child: CircularProgressIndicator(),):CustomFlatButton(()
                async {
               bool  response= await AuthServices().requestResetPassword(emailController.text);
               response?Get.dialog(_showConfirmationDialog()):SizedBox();
                  }, "Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _showConfirmationDialog(){
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        // constraints: BoxConstraints(maxHeight: 375,maxWidth: 325),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 82),
                child: Image.asset(
                  "assets/images/OnSuccess.png",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: CustomText().CustomTitle(
                  "Reset Password",
                  24,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: CustomText().CustomDesc(
                  "A password reset link has been sent to your email. Check your inbox and spam folder to reset your password.",
                  14,
                  TextAlign.center,
                  1.6,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                width: double.infinity,
                child: CustomFlatButton(() {
                  Get.offNamed(LoginScreen.route);
                }, "Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
