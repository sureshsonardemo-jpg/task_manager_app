import 'package:flutter/material.dart';

import '../../res/colors.dart' show AppColors;
import 'customTextStyles.dart' show CustomTextStyles;
class CustomText{
  Widget CustomTitle(String title, double fontSize) {
    return Text(
      title,
      style: CustomTextStyles().SemiBoldTextStyle().copyWith(
        fontSize: fontSize,
        color: AppColors.textTitleBlack,
        letterSpacing: 0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget CustomDesc(String desc, double fontSize,TextAlign txtalign,double lineheight){
    return Text(
      desc,
      style: CustomTextStyles()
          .RegularTextStyle()
          .copyWith(
        fontSize:fontSize,
        color: AppColors.textGrey,
        letterSpacing: 0,
        height: lineheight,
      ),
      textAlign:txtalign,
    );
  }


}
