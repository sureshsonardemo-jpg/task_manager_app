import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:task_manager_app/res/colors.dart' show AppColors;

import '../../controller/login_controller.dart';


class AppTextfields {
  TextField Simple_TextField(
    String hintText,
    bool isDate,
    TextEditingController controller,
    VoidCallback? ontap,
  ) {
    return TextField(
      controller: controller,
      onTap: isDate ? ontap : null,
      readOnly: isDate,
      decoration: InputDecoration(
        border: InputBorder.none,
        hint: Text(
          hintText,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.5,
            letterSpacing: 0,
            color: AppColors.textTitleBlack,
          ),
        ),
      ),
    );
  }

  TextFormField Profile_TextField(
    String hintText,
    TextEditingController controller,
    String? SvgPath,
     bool isReadonly
  ) {
    return TextFormField(
      readOnly: isReadonly,
      validator: (value) {
        if (value == null || value.isEmpty ) {
        return 'This field cannot be empty';
        }
        return null; // Return null if the data is valid
      },
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.midGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.midGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.midGrey),
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        hintText: hintText,
        prefixIcon: SvgPath == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(SvgPath, height: 22, width: 22),
              ),
      ),
      style: GoogleFonts.beVietnamPro(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.textGrey,
        letterSpacing: 0,
        height: 1.5,
      ),
    );
  }


  Widget TitleAndField(
    TextEditingController controller,
    String txt,
    String hinttxt,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          txt,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.textTitleBlack,
            height: 1.5,
            letterSpacing: 0,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hinttxt,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          ),
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.textGrey,
            letterSpacing: 0,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget CustomTextField(
    double txtFontSize,
    String txt,
    String hinttxt,
    bool ispass,
    bool withoutprefix,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          txt,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w600,
            fontSize: txtFontSize,
            color: AppColors.textTitleBlack,
            letterSpacing: 0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 5), //compromised
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null; // Return null if the data is valid
          },
          controller: controller,
          obscureText: ispass ? Get.find<LoginController>().isHidden.value : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: AppColors.textFieldBorder,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            hintText: hinttxt,
            prefixIcon: withoutprefix
                ? Icon(null)
                : ispass
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/lock.svg",
                      height: 20,
                      width: 20,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/sms.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
            suffixIcon: ispass
                ? IconButton(
                    onPressed: () {
                      Get.find<LoginController>().togglepass();
                    },
                    icon: Get.find<LoginController>().isHidden.value
                        ? Icon(
                            Icons.visibility_outlined,
                            size: 24,
                            color: AppColors.textGrey,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            size: 24,
                            color: AppColors.textGrey,
                          ),
                  )
                : Icon(null),
          ),
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.textGrey,
            letterSpacing: 0,
            height: 1.5,
          ),
        ),
      ],
    );
  }



}
/*this is too late for chanages
class Simple__TextFelds extends StatelessWidget {
   Simple__TextFelds({super.key});
  TextEditingController controller;
  String hintText;
      bool isDate;
      VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: isDate ? ontap : null,
      readOnly: isDate,
      decoration: InputDecoration(
        border: InputBorder.none,
        hint: Text(
          hintText,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.5,
            letterSpacing: 0,
            color: AppColors.textTitleBlack,
          ),
        ),
      ),
    );
  }
}
*/
