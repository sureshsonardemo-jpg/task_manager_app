import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import 'customTextStyles.dart';

Widget CustomFlatButton(VoidCallback onpressed, String txt) {
  return TextButton(
      onPressed: onpressed, child: Text(txt,style: CustomTextStyles().SemiBoldTextStyle().copyWith(fontSize: 16,color: AppColors.white,height: 1.5),));
}
