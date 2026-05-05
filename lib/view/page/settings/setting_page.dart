
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/data_models/menu_item_model.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/view/page/settings/language_page.dart';
import 'package:task_manager_app/view/page/settings/profile_details_page.dart';
import 'package:task_manager_app/view/widget/confirmation_dialog.dart';
import 'package:task_manager_app/view/widget/settings/menu_item.dart';
import 'package:task_manager_app/view/widget/settings/user_details_tile.dart';
import 'package:task_manager_app/view/widget/upper_bar/common_upper_bar.dart';
import '../../../controller/home_controller.dart';
import '../../../res/colors.dart' show AppColors;

class SettingPage extends StatelessWidget {
  final UserModel userModel;
   SettingPage({super.key,required this.userModel});
  static const String route="Main-Setting=Page";
  final homeController = Get.find<HomeController>();


  final List<MenuItemModel> listOfMenuItems=[
    MenuItemModel("assets/images/translate.svg", "Language", AppColors.textTitleBlack),
    MenuItemModel( "assets/images/logout.svg",  "Log out",  AppColors.red)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 44),
            //Upper Bar
            CommonUpperBar(onBack: () =>homeController.pageIndex.value=0,middleTxt: "Settings",),
            SizedBox(height: 24),
            GestureDetector(onTap: () => Get.to(ProfileDetailsPage(usr: userModel )),
                child: UserDetailsTile(currentUsr: userModel)),
            SizedBox(height: 20),
            Container(padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  GestureDetector( onTap: () {
                    Get.toNamed(LanguagePage.route);
                  },
                      child: MenuItem(item: listOfMenuItems[0])),
                  Divider(),
                  GestureDetector(onTap: () {
                    Get.dialog(
                      ConfirmationDialog(gapHeight: 20, imgPath: "assets/images/OnLogout.png", titletxt: "Log out?", bodytxt: "Are you sure you want to log out?",
                        canceltxt: "No", confirmtxt: "Yes",
                        onDelete: () async {
                         await Supabase.instance.client.auth.signOut();
                        // automatically redirects user to login screen
                      },)
                    );
                  },
                      child: MenuItem(item: listOfMenuItems[1]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
    }
