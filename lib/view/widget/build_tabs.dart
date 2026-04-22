import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/res/colors.dart';

Widget BuildTab(String title, int index, HomeController controller) {
  return GestureDetector(
    onTap: () => controller.changeTab(index),
    child: Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected?Border.all(color: AppColors.purple):BoxBorder.all()
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Text(
            title,
            style: GoogleFonts.beVietnamPro(
              color: isSelected ?AppColors.white :AppColors.textTitleBlack,
              fontSize: 14,height: 1.5,
              fontWeight: isSelected?FontWeight.w600:FontWeight.w400
            ),
          ),
        ),
      );
    }),
  );
}