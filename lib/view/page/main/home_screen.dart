import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/widget/customTextStyles.dart';
import 'package:task_manager_app/view/widget/search_field.dart';
import 'package:task_manager_app/view/widget/task_card.dart';

import '../../widget/build_tabs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String route = "Home=screen";

  var searchController = TextEditingController();

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    String usr = "Jack";
    return Scaffold(
      backgroundColor: AppColors.homeBG,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,$usr 👋",
                style: CustomTextStyles().BoldTextStyle().copyWith(
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              Text(
                "Let’s get things done today.",
                style: GoogleFonts.mukta(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTextGrey,
                ),
              ),
              SearchField(controller: searchController),
              Container(
                margin: EdgeInsets.only(top: 20, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildTab("All", 0, homeController),
                    BuildTab("Pending", 1, homeController),
                    BuildTab("Completed", 2, homeController),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Obx(() {
                    switch (homeController.selectedIndex.value) {
                      case 0:
                        return buildList();
                      case 1:
                        return buildList();
                      case 2:
                        return buildList();
                      default:
                        return buildList();
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    log("build list called");
    return  ListView.builder(
      itemCount: homeController.taskList.length,
        itemBuilder: (context, index) => TaskCard(
          taskModel: homeController.taskList.value[index],
          index: index,
          controller:homeController,
        ),
      );

  }
}
