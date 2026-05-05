

import 'package:get/get.dart';


class LoginController extends GetxController{


  //for password
  RxBool isHidden=true.obs;
  void togglepass(){
    isHidden.value=!isHidden.value;
  }
  RxBool cPassIsHiddedn=true.obs;
  
  RxBool isChecked=false.obs;
  void toggleCheckbox(){
    isChecked.value=!isChecked.value;
  }
  RxBool isLoading=false.obs;
}