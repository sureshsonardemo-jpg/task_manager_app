
import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/data_models/user_model.dart';

import '../view/page/auth/login_screen.dart';
import '../view/page/main/main_screen.dart';
import 'home_controller.dart';

class LoginController extends GetxController{


  //for password
  RxBool isHidden=true.obs;
  togglepass(){
    isHidden.value=!isHidden.value;
  }
  RxBool cPassIsHiddedn=true.obs;
  
  RxBool isChecked=false.obs;
  toggleCheckbox(){
    isChecked.value=!isChecked.value;
  }
  RxBool isLoading=false.obs;

}