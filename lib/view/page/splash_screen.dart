import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/app_services/app_services.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/res/app_constants.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/page/main/main_screen.dart';
import 'package:task_manager_app/view/page/on_boarding_screen.dart';

import '../../services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = "/";


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController=Get.find<AuthController>();
  @override
  void initState() {
    _splashTimer();
    AuthServices.configDeepLink(context);
    super.initState();
  }

 Future<void> _splashTimer() async {
   await Future.delayed(Duration(seconds: 2),() {
     _handleStartup();
   },);
  }

  Future<void> _handleStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final bool haveSeenIntro = prefs.getBool(AppConstants.hasSeenIntro) ?? false;
    final session = Supabase.instance.client.auth.currentSession;
    List<String>? tempList=prefs.getStringList(AppConstants.currentUser);
    if (!haveSeenIntro) {
      Get.offAllNamed(OnBoardingScreen.route);
    }
    else if (session == null ) {
      //new user should be on login page
      log("session ==null this function fired and moving to login");
      Get.offAllNamed(LoginScreen.route);
    }
    else
    { // 3 cases
      // user registers(makes a short time session =no need to call fetchUser())
      // logins (session made = need to call fetchUser()) already done
      // user is already login(session is stored already =no need to call fetchUser()) handled below
      // user logins with google (ession made =need to call fetch User())
      if(tempList!=null){
        log("tempList!=null");
        final UserModel alreadyLoggedInUser=UserModel(id: tempList[0],firstName: tempList[1],lastName: tempList[2],email: tempList[3]);
         Get.offAll(MainScreen(user: alreadyLoggedInUser));
      }
      else{
        AppServices.showSnackBar(SnackBarType.error, "Cant find user" );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.purple,
      body:  Center(child: Image.asset("assets/images/main_logo.png")),
    );
  }
}
