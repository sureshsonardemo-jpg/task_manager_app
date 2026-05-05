import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;

class SearchField extends StatelessWidget {
  final  controller;
 final String hinttext;
  SearchField({super.key,required this.controller,required this.hinttext});
 final homeContrller=Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        style: GoogleFonts.beVietnamPro(
          color: AppColors.subTextGrey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        onChanged: (value) {
          homeContrller.filterList(value);
        },
        controller:controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 24,
            color: Color.fromRGBO(119, 119, 119, 0.7),
          ),
          border: InputBorder.none,
          hint: Text(
            hinttext,
            style: GoogleFonts.beVietnamPro(
              color: AppColors.subTextGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
