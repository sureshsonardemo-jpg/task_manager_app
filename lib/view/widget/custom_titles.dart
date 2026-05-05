import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import '../../res/colors.dart' show AppColors;
class CustomText{
  Widget CustomTitle(String title, double fontSize) {
    return Text(
      title,
      style: GoogleFonts.beVietnamPro(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: AppColors.textTitleBlack,
        letterSpacing: 0,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget CustomDesc(String desc, double fontSize,TextAlign txtalign,double lineheight){
    return Text(
      desc,
      style: GoogleFonts.beVietnamPro(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: AppColors.textGrey,
        height: lineheight,
        letterSpacing: 0,
      ),
      textAlign:txtalign,
    );
  }


}
