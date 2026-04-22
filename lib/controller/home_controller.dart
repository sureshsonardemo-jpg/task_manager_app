import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data_models/task_model.dart' show TaskModel;

class HomeController extends GetxController{
  RxInt selectedIndex = 0.obs;

  RxList<TaskModel> taskList=[
    TaskModel(title: "Interview", description: "description", created_date: "04/01/2026", due_date: "12/02/206",isCompleted: false),
    TaskModel(title: "task2 ", description: "Long Long Long Long Long Long Long Long Long Long Long Long description ", created_date: "04/01/2026", due_date: "12/02/206",isCompleted: false),
    TaskModel(title: "Long Long Long Long Long Long Long Long  title", description: "Long Long Long Long Long Long Long Long Long Long Long Long decription", created_date: "04/01/2026", due_date: "12/02/206",isCompleted: true),
  ].obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

}