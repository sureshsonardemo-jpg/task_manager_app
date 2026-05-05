import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data_models/task_model.dart' show TaskModel;

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;
  late final StreamSubscription _taskSub;
  RxList<TaskModel> taskList = <TaskModel>[].obs;
  RxList<TaskModel> get pendingTasks => taskList.where((e) => e.isCompleted==false).toList().obs;
  RxList<TaskModel> get completedTasks => taskList.where((e) => e.isCompleted==true,).toList().obs;
  RxList<TaskModel>  filteredList = <TaskModel>[].obs;

  @override
  void onInit() {
    listenToTasks();
    filteredList.assignAll(taskList);
    super.onInit();
  }

  void listenToTasks()   {
    _taskSub=supabase.from("tasks").stream(primaryKey: ['id'])
        .listen((data) {
           taskList.value=data.map((e) => TaskModel.fromJson(e)).toList();
           filteredList.assignAll(taskList);
        }
    );
  }

  void filterList(String query){
    if(query.isEmpty){
      filteredList.assignAll(taskList);
      log("empty ${filteredList.length}");
    }
    else{
      filteredList.value=taskList.where((e) => e.title!.toLowerCase().contains(query.toLowerCase())
          || e.description!.toLowerCase().contains(query.toLowerCase())).toList().obs;
      log("not empty ${filteredList.length}");
    }
  }

  RxInt selectedIndex = 0.obs;
  //for navbar pagging navigation
  RxInt pageIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }
  @override
  void onClose() {
    super.onClose();
    _taskSub.cancel();
  }
}
