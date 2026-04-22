import 'dart:developer';

import 'package:get/get.dart';

class AuthController extends GetxController{
  //for password
  RxBool istrue=true.obs;
  togglepass(){
    istrue.value=!istrue.value;
  }
  RxBool isChecked=false.obs;
  toggleCheckbox(){
    isChecked.value=!isChecked.value;
  }
}