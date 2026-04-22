import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/view/widget/customTextStyles.dart' show CustomTextStyles;

Widget CustomTextField(String txt,String hinttxt,bool ispass,bool withoutprefix){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(txt, style: CustomTextStyles().MediumTextStyle().copyWith(
        fontSize:15.5,
        height: 1.5,
      )),
       SizedBox(height: 5,),//compromised
       TextField(
          obscureText: ispass?Get.find<AuthController>().istrue.value:false,
          decoration: InputDecoration(
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: AppColors.TextfieldborderColor,style: BorderStyle.solid,width: 1)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: AppColors.TextfieldborderColor,style: BorderStyle.solid,width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: AppColors.TextfieldborderColor,style: BorderStyle.solid,width: 1),
              ) ,contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 13),
              hintText: hinttxt,
              prefixIcon: withoutprefix?Icon(null):ispass?Icon(Icons.lock_outline,size: 24,color: AppColors.textGrey):Icon(Icons.email_outlined,size: 24,color: AppColors.textGrey),
            suffixIcon: ispass?
            IconButton(onPressed: () {
              Get.find<AuthController>().togglepass();
            }, icon: Get.find<AuthController>().istrue.value?Icon(Icons.visibility_outlined,size:24,color: AppColors.textGrey):Icon(Icons.visibility_off_outlined,size:24,color: AppColors.textGrey)):Icon(null)
          ),
        ),

    ],
  );
}