import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/page/settings/edit_profile_page.dart';
import 'package:task_manager_app/view/widget/confirmation_dialog.dart';

import '../../widget/upper_bar/common_upper_bar.dart';

class ProfileDetailsPage extends StatelessWidget {
  final UserModel usr;
   ProfileDetailsPage({super.key, required this.usr});
  final loginController= Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44),
            //Upper Bar
            CommonUpperBar(
              onBack: () => Get.back(),
              middleTxt: "Profile Details",
              trailing: GestureDetector(
                onTap: () {
                  Get.to(EditProfilePage(usr: usr));
                },
                child: SvgPicture.asset("assets/images/edit_black.svg"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 28),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset(usr.imageUrl, height: 80, width: 80),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                "First Name",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Text(
                  usr.firstName,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                "Last Name",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Text(
                  usr.lastName,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                "Email Address",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontSize: 12),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Text(
                  usr.email,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 34),
              child: Obx(() => loginController.isLoading.value?const Center(child:  CircularProgressIndicator()):OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                      ConfirmationDialog(
                        gapHeight: 30,
                        imgPath: "assets/images/OnDelete.png",
                        titletxt: "Delete Account",
                        bodytxt:
                            "Are you sure you want to delete this account? All your data will be erased.",
                        canceltxt: "No, Keep it",
                        confirmtxt: "Yes, Delete",
                        onDelete: () {
                          AuthServices().deleteAccount();
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: Text("Delete Account"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
