import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/widget/confirmation_dialog.dart';

import '../../../data_models/task_model.dart' show TaskModel;
import '../../../data_models/user_model.dart' show UserModel;
import '../../widget/build_tabs.dart' show BuildTab;
import '../../widget/empty_task.dart' show EmptyTaskWidget;
import '../../widget/search_field.dart' show SearchField;
import '../../widget/task_card.dart' show TaskCard;
import 'add_new_task.dart' show AddNewTask;
import 'task_detail_page.dart' show TaskDetailPage;

class HomePage extends StatelessWidget {
  final UserModel userModel;
  HomePage({super.key, required this.userModel});
  final searchController = TextEditingController();
  final homeController = Get.put(HomeController());
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 246, 252, 1),
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello'.tr+" ${userModel.firstName} 👋",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 18, height: 1.5),
            ),
            Text(
              "Let’s get things done today.".tr,
              style: GoogleFonts.mukta(
                height: 1.5,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.subTextGrey,
              ),
            ),
            //search field
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SearchField(
                controller: searchController,
                hinttext: "Search Tasks...",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildTab("All", 0, homeController),
                  BuildTab("Pending", 1, homeController),
                  BuildTab("Completed", 2, homeController),
                ],
              ),
            ),
            // listviewbuilder
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 24),
                child: Obx(() {
                  switch (homeController.selectedIndex.value) {
                    case 0:
                      if (homeController.filteredList.isEmpty) {
                        return EmptyTaskWidget();
                      }
                      return buildList(homeController.filteredList);
                    case 1:
                      if (homeController.pendingTasks.isEmpty) {
                      return EmptyTaskWidget();
                    }
                    return buildList(homeController.pendingTasks);
                    case 2:
                      if (homeController.completedTasks.isEmpty) {
                        return EmptyTaskWidget();
                      }
                      return buildList(homeController.completedTasks);
                    default:
                      if (homeController.taskList.isEmpty) {
                        return EmptyTaskWidget();
                      }
                      return buildList(homeController.taskList);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(RxList<TaskModel> list) {
    return Obx(() => ListView.builder(
        itemCount:list.length,
        itemBuilder: (context, index) {
          final task = list[index];
          return TaskCard(
            taskModel: task,
            onTap: () {
              Get.to(
                TaskDetailPage(
                  item: task,
                  onDelete: () {
                    log("delete pressed ");
                    Get.dialog(
                      ConfirmationDialog(
                        gapHeight: 36,
                        imgPath: "assets/images/OnDelete.png",
                        titletxt: 'Delete Task',
                        bodytxt: " Are you sure you want to delete this Task?",
                        canceltxt: "No, Keep it",
                        confirmtxt: "Yes, Delete",
                        onDelete: () {
                          AuthServices().deleteTask(list[index].id!);
                          Get.back();
                          Get.back();
                        },
                      ),
                    );
                  },
                  onEdit: () {
                    Get.off(AddNewTask(isNewRecord: false, item: task));
                  },
                ),
              );
            },
            onCheck: () {
              if (!task.is_completed!) {
                task.is_completed = true;
                homeController.taskList[index].is_completed = true;
                //update task
                var temp = TaskModel(id:task.id, is_completed: true, title: task.title, description: task.description, created_at: DateTime.now().toString(), due_date: task.due_date);
                AuthServices().updateTask(temp);
                Get.back();
              } else {
                Get.closeCurrentSnackbar();
                Get.snackbar("Mistake", "Already Checked");
              }
            },
            onEdit: () {
              Get.to(AddNewTask(isNewRecord: false, item: task));
            },
            onDelete: () {
              Get.dialog(
                ConfirmationDialog(
                  gapHeight: 36,
                  imgPath: "assets/images/OnDelete.png",
                  titletxt: 'Delete Task',
                  bodytxt: " Are you sure you want to delete this Task?",
                  canceltxt: "No, Keep it",
                  confirmtxt: "Yes, Delete",
                  onDelete: (){
                    AuthServices().deleteTask(homeController.taskList[index].id!);
                    Get.back();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

}
