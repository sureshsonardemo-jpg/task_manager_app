import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import '../../res/colors.dart';

Widget CustomFlatButton(VoidCallback onpressed, String txt) {
  return TextButton(
    style: TextButton.styleFrom(backgroundColor: AppColors.purple),
    onPressed: onpressed,
    child: Text(
      txt,
      style: GoogleFonts.beVietnamPro(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.white,
        letterSpacing: 0,
        height: 1.5,
      ),
    ),
  );
}
