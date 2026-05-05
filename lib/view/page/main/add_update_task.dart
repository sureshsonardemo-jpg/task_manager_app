import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/task_model.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/services/auth_services.dart';
import 'package:task_manager_app/view/widget/app_textfields.dart';
import 'package:task_manager_app/view/widget/custom_flat_button.dart';
import 'package:task_manager_app/view/widget/upper_bar/common_upper_bar.dart';

import '../../../app_services/app_services.dart' show AppServices, SnackBarType;
import '../../widget/confirmation_dialog.dart' show ConfirmationDialog;

class AddEditTask extends StatefulWidget {
  final bool isNewRecord;
  final TaskModel? item;

  const AddEditTask({this.item, this.isNewRecord = true, super.key})
    : assert(
        isNewRecord || item != null,
        'If isNewRecord is false, an item must be provided.',
      );

  static const route = "Add-New-Task-Screen";

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  final loginController=Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
    if (!widget.isNewRecord) {
      titleController.text = widget.item!.title!;
      descriptionController.text = widget.item!.description!;
      dueController.text = widget.item!.dueDate!;
    }
  }

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44),
            CommonUpperBar(
              onBack: () => Get.back(),
              middleTxt: widget.isNewRecord
                  ? "Create Task".tr
                  : "Edit Task Details".tr,
              trailing: widget.isNewRecord
                  ? null
                  : InkWell(
                onTap: () {
                  Get.dialog(
                    ConfirmationDialog(
                      gapHeight: 36,
                      imgPath: "assets/images/OnDelete.png",
                      titletxt: 'Delete Task',
                      bodytxt: " Are you sure you want to delete this Task?",
                      canceltxt: "No, Keep it",
                      confirmtxt: "Yes, Delete",
                      onDelete: () {
                        AuthServices().deleteTask(widget.item!.id!);
                        Get.back();
                        Get.back();
                      },
                    ),
                  );
                },
                      child: SvgPicture.asset("assets/images/delete.svg"),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                "Task Title",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: AppTextfields().Simple_TextField(
                  "eg. Interview",
                  false,
                  titleController,
                  null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                "Description",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: AppTextfields().Simple_TextField(
                  "eg. UI/UX Interview",
                  false,
                  descriptionController,
                  null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                "Due Date",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/calendar.svg",
                      height: 20,
                      width: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AppTextfields().Simple_TextField(
                        "dd/mm/yy",
                        true,
                        dueController,
                        () async {
                          //date picker
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialEntryMode: DatePickerEntryMode.input,
                            initialDatePickerMode: DatePickerMode.year,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          String formatedDate =
                              "${pickeddate!.day}/${pickeddate.month}/${pickeddate.year}";
                          dueController.text = formatedDate;
                          log("due date chnaged ${dueController.text}");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //for responsive space
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              width: double.infinity,
              height: 48,
              child: Obx(() => loginController.isLoading.value?const Center(child: CircularProgressIndicator()):CustomFlatButton(() {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      dueController.text.isNotEmpty) {
                    if (widget.isNewRecord) {
                      //add new task
                      var temp = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        createdAt: DateTime.now().toString(),
                        dueDate: dueController.text,
                        isCompleted: false,
                      );
                      AuthServices().addNewTask(temp);
                      Get.back();
                    } else {
                      //update task
                      var temp = TaskModel(
                        id:widget.item!.id ,
                        title: titleController.text,
                        description: descriptionController.text,
                        createdAt: DateTime.now().toString(),
                        dueDate: dueController.text,
                        isCompleted: widget.item!.isCompleted,
                      );
                      log("btn tapped!! with data $temp");
                      AuthServices().updateTask(temp);
                      // Get.back();
                    }
                  } else {
                    //empty fields exception handled
                    AppServices.showSnackBar(SnackBarType.info, "Please Fill All Required Details");
                  }
                }, "Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
