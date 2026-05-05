import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/res/app_constants.dart';

import '../app_services/app_services.dart' show AppServices, SnackBarType;
import '../view/page/auth/login_screen.dart' show LoginScreen;
import '../view/page/main/main_screen.dart' show MainScreen;
import 'home_controller.dart' show HomeController;

class AuthController extends GetxController {
  bool isFirsTimeOfGoogleUser=true;
  late final StreamSubscription _authSub;
  //this is no longer in useful
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    _authSub = Supabase.instance.client.auth.onAuthStateChange.listen ((data)  async {
      final event = data.event;
      if (event == AuthChangeEvent.signedOut) {
        Get.delete<HomeController>();
        SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.remove(AppConstants.currentUser);
        Get.offAllNamed(LoginScreen.route);
      } else if (event == AuthChangeEvent.signedIn) {
        Get.delete<HomeController>();
        final tempUsr= await fetchUser();
        tempUsr!=null?Get.offAll(MainScreen(user: tempUsr)):
        AppServices.showSnackBar(SnackBarType.error, "Cant find user");
      }
      else if(event ==AuthChangeEvent.userUpdated){
        log("user updated");
        Get.delete<HomeController>();
        final tempUsr= await fetchUser();
        tempUsr!=null?Get.offAll(MainScreen(user: tempUsr)):
        AppServices.showSnackBar(SnackBarType.error, "Cant find user");
      }
    });
  }

  Future<UserModel?> fetchUser() async {
    try{
      log("fetch user  called");
      User? user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        log("user is null");
        //if user is not fetched then dont go to mainscr
        return null;
      } else {
        //if user is google user login first time his details will be null then we have to give default name to him then next time his data would be their he can update his name
        final appMetaData=user.appMetadata;
         if(appMetaData['provider']=="google" && isFirsTimeOfGoogleUser){
         final usr = UserModel(
           id: user.id,
           email: user.email!,
           firstName:'User' ,
           lastName: 'Name ',
         );
         currentUser.value = usr;
         SharedPreferences prefs=await SharedPreferences.getInstance();
         prefs.setStringList(AppConstants.currentUser,[usr.id,usr.firstName,usr.lastName,usr.email,]);
         isFirsTimeOfGoogleUser=false;
         return usr;
       } 
       else{
         final userProfile = await Supabase.instance.client
             .from("profiles")
             .select()
             .eq("id", user.id)
             .single();
         final usr = UserModel(
           id: user.id,
           email: user.email!,
           firstName: userProfile['first_name'],
           lastName: userProfile['last_name'],
         );
         log("data fetched successfully");
         currentUser.value = usr;
         //logic for storing user in prefs so when user open app later he still find himself Signed in
         SharedPreferences prefs=await SharedPreferences.getInstance();
         prefs.setStringList(AppConstants.currentUser,[usr.id,usr.firstName,usr.lastName,usr.email,]);
         return usr;
       }

      }
    }
    catch(e){
      log("fetchig user error ${e.toString()}");
    }
    return null;
    }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }
}
