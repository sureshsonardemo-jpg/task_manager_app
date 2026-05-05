
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';

import 'package:task_manager_app/view/widget/custom_titles.dart';

import '../../widget/app_textfields.dart' show AppTextfields;

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  static const String route="Reset-pass-scr";
  final emailController=TextEditingController();
  final passController=TextEditingController();

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
                child: Container(margin: EdgeInsets.only(top: 24),
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
              ),
              Container(margin: EdgeInsets.only(top: 24),
                child: CustomText().CustomTitle("Reset Password", 24),
              ),
              Container(margin: EdgeInsets.only(top: 12),
                  child: CustomText().CustomDesc("Enter new password", 14,TextAlign.start,1.6)),
              Container(margin: EdgeInsets.only(top: 12),
                  child:AppTextfields().CustomTextField(14,"Password", "* * * * *", true, false,passController)
              ),
              Spacer(),
              Container(margin: EdgeInsets.only(top: 12,bottom: 12),width: double.infinity,height: 48,
                child: CustomFlatButton(()  {
                  AuthServices().resetPassword(passController.text);
                  Get.back();
                }, "Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}