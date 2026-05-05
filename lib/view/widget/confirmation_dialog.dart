import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'custom_flat_button.dart' show CustomFlatButton;


class ConfirmationDialog extends StatelessWidget {
  final String imgPath,titletxt,bodytxt,canceltxt,confirmtxt;
  final VoidCallback onDelete;
  final double gapHeight;
  const ConfirmationDialog({super.key,required this.gapHeight, required this.imgPath, required this.titletxt, required this.bodytxt, required this.canceltxt, required this.confirmtxt, required this.onDelete,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imgPath,),
              SizedBox(height: gapHeight),
             Container(padding: EdgeInsets.symmetric(horizontal: 8),
               child: Column(
                 children: [
                   Text(
                     titletxt,
                     style: Theme.of(context).textTheme.titleMedium,
                     textAlign: TextAlign.center,
                   ),
                   SizedBox(height: gapHeight>28?8:12,),
                   Text(
                     bodytxt,
                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                     ),
                     textAlign: TextAlign.center,
                   ),
                 ],
               ),
             ),
              SizedBox(height: gapHeight),
              Row(
                children: [
                  Expanded(flex: 1,
                    child: SizedBox(height: gapHeight>28?40:48,
                      child: OutlinedButton(
                        onPressed: onDelete,
                        child: Text(confirmtxt),
                      ),
                    ),
                  ),
                  SizedBox(width: gapHeight>28?8:12,),
                  Expanded(flex: 1,
                    child: SizedBox(height: gapHeight>28?40:48,
                      child: CustomFlatButton(() {
                        Get.back();
                      }, canceltxt),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
