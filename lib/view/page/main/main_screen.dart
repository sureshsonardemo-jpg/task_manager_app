
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/main/add_update_task.dart';
import 'package:task_manager_app/view/page/main/home_page.dart';
import 'package:task_manager_app/view/page/settings/setting_page.dart';

class MainScreen extends StatefulWidget {
  final UserModel user;
   const MainScreen({super.key,required this.user});
  static const String route = "Home=screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    List<Widget> pages=<Widget>[];

  @override
  void initState() {
    super.initState();
      pages=[
      HomePage(userModel: widget.user),
      SettingPage(userModel: widget.user,)];
      Get.lazyPut<HomeController>(() => HomeController());
      Get.put(LoginController());
  }
@override
  void dispose() {
    searchController.dispose();
    homeController.dispose();
    super.dispose();
  }
  var searchController = TextEditingController();
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.homeBG,
      body: Obx(() =>  IndexedStack(
          index: homeController.pageIndex.value,
          children: pages,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddEditTask(isNewRecord: true));
        },
        backgroundColor: AppColors.purple,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Obx(() =>  Container(
        height: 94,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                    onTap: ()
                    {
                      homeController.pageIndex.value==0?null:homeController.pageIndex.value=0;
                      log("home tapped");
                    },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    homeController.pageIndex.value==0?"assets/images/home_active.svg":
                    "assets/images/home.svg",
                    height: 24,
                    width: 24,
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color:  homeController.pageIndex.value==0?AppColors.purple:AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(onTap: (){
              homeController.pageIndex.value==1?null:homeController.pageIndex.value=1;
              log("setting tapped");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    homeController.pageIndex.value==1?"assets/images/setting_active.svg":
                    "assets/images/setting.svg",
                    height: 24,
                    width: 24,
                  ),
                  Text(
                    "Settings",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color:  homeController.pageIndex.value==1?AppColors.purple:AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
  }
}
