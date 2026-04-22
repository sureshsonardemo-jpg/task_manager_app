import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/data_models/task_model.dart';
import 'package:task_manager_app/res/colors.dart';

class TaskCard extends StatelessWidget {
  TaskModel taskModel;
  int index;
  HomeController controller;
  TaskCard({
    super.key,
    required this.taskModel,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    log("Task Card build for index ${index}");
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Color.fromRGBO(226, 226, 226, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskModel.title,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.5,
                      color: AppColors.textTitleBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    taskModel.description,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Due: ${taskModel.due_date}",
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.5,
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //edit+delete icons
                SizedBox(
                  width: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/images/delete.svg",
                          height: 22,
                          width: 22,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/images/edit.svg",
                          height: 22,
                          width: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Obx(() =>  InkWell(
                    onTap: controller.taskList.value[index].isCompleted ? null : () {
                            controller.taskList.value[index].isCompleted= true;
                            log("button clicked value is: ${ controller.taskList[index].isCompleted}");
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: taskModel.isCompleted
                            ? AppColors.blueBG1
                            : AppColors.greenBG1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          taskModel.isCompleted
                              ? "Completed"
                              : "Mark as completed",
                          style: GoogleFonts.beVietnamPro(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 1.5,
                            color: taskModel.isCompleted
                                ? AppColors.blue
                                : AppColors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
