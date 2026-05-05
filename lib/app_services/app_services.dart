import 'package:get/get.dart';

enum SnackBarType{
  info,
  success,
  error
}

class AppServices {
  static void showSnackBar(SnackBarType type,String msg){
    Get.closeAllSnackbars();
    Get.snackbar(type.name.capitalizeFirst??'Info', msg);
  }
}