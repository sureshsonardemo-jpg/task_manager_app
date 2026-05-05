import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app_services/app_services.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/widget/app_textfields.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import '../../widget/upper_bar/common_upper_bar.dart' show CommonUpperBar;

class EditProfilePage extends StatelessWidget {
  final UserModel usr;
  EditProfilePage({super.key, required this.usr});
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final loginController=Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = usr.firstName;
    lastNameController.text = usr.lastName;
    emailController.text = usr.email;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44),
              //Upper Bar
              CommonUpperBar(
                onBack: () => Get.back(),
                middleTxt: "Profile Details",
              ),
              //image
              Container(
                margin: EdgeInsets.only(top: 28),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.asset(usr.imageUrl, height: 80, width: 80),
                    SvgPicture.asset("assets/images/wrap_camera.svg"),
                  ],
                ),
              ),
              SizedBox(height: 24),
              //form
              Text(
                "First Name",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
              SizedBox(height: 4),
              AppTextfields().Profile_TextField(
                "eg. jack",
                firstNameController,
                null,
                false
              ),
              Text(
                "Last Name",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
              SizedBox(height: 4),
              AppTextfields().Profile_TextField(
                "eg. rob",
                lastNameController,
                null,
                false
              ),
              Text(
                "Email Address",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
              SizedBox(height: 4),
              AppTextfields().Profile_TextField(
                "eg.  jackrob187@gmail.com",
                emailController,
                "assets/images/sms.svg",
                true
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                width: double.infinity,
                height: 48,
                child: Obx(() => loginController.isLoading.value?const Center(child: CircularProgressIndicator(),):CustomFlatButton((){
                    if(_formKey.currentState!.validate()){
                      if(firstNameController.text ==usr.firstName
                          && lastNameController.text ==usr.lastName){
                        AppServices.showSnackBar(SnackBarType.info, "Current values should be different from previous values");
                      }
                      else{AuthServices().updateAccount(firstNameController.text, lastNameController.text);}
                    }
                  }, "Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
