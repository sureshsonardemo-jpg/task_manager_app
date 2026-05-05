import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:task_manager_app/res/colors.dart' show AppColors;

class CommonUpperBar extends StatelessWidget {
  final VoidCallback? onBack;
  final String? middleTxt;
  final Widget? trailing;

  const CommonUpperBar({super.key, this.onBack, this.middleTxt, this.trailing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Left + Right layer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Back Button
              if (onBack != null)
                InkWell(
                  onTap: onBack,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromRGBO(229, 226, 227, 1),
                      ),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_sharp, size: 24),
                  ),
                )
              else
                const SizedBox(width: 45),

              /// Trailing
              trailing ?? const SizedBox(width: 45),
            ],
          ),

          /// Center Title (always centered)
          if (middleTxt != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                middleTxt!,
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.5,
                  color: AppColors.textTitleBlack,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

/*
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ?isBackBtn?InkWell(
          onTap: onBack,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromRGBO(229, 226, 227, 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ):SizedBox(height: 45,width: 45,),
        ?isMiddleTxt?Text(
          middleTxt!,
          style: GoogleFonts.beVietnamPro(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              height: 1.5,
              color: AppColors.textTitleBlack
          ),
          textAlign: TextAlign.center,
        ):SizedBox(),
        //SvgPicture.asset("assets/images/delete.svg",height: 24,width: 24,),
        ?isTrailing
            ?InkWell(
          child: SvgPicture.asset(
            svgPath!,
            height: 24,
            width: 24,
          ),
        )
      ],
    );


* */
