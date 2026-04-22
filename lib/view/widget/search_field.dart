import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;

class SearchField extends StatelessWidget {
  var controller;
   SearchField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller:controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Color.fromRGBO(119, 119, 119, 0.7),
          ),
          border: InputBorder.none,
          hint: Text(
            "Search tasks..",
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
