import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/app_services/app_services.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/task_model.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/page/auth/reset_password_scr.dart';

class AuthServices extends GetxController {
  final supabase = Supabase.instance.client;
  final loginController=Get.put(LoginController());
  final homeController=Get.put(HomeController());
  static void configDeepLink(BuildContext context) {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        Supabase.instance.client.auth.getSessionFromUrl(uri);
        if (uri.host == 'password-reset') {
          Get.to(ResetPasswordScreen());
        }
      }
    });
  }
  Future<void> continueWithGoogle() async {
    try {
      loginController.isLoading.value=true;
      GoogleSignIn signIn = GoogleSignIn.instance;
      signIn.initialize(
        serverClientId: dotenv.env['WEB_CLIENT'],
        clientId: Platform.isAndroid ? dotenv.env['ANDROID_CLIENT'] : dotenv
            .env['IOS_CLIENT'],
      );

      // Perform the sign in
      final googleAccount = await signIn.authenticate();
      final googleAuthorization = await googleAccount.authorizationClient
          .authorizationForScopes(['email', 'profile']) ??
          await googleAccount.authorizationClient.authorizeScopes(
              ['email', 'profile']);
      final idToken = googleAccount.authentication.idToken;
      final accessToken = googleAuthorization.accessToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final result = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // navgation after google sign in
      if (result.user != null && result.session != null) {
        loginController.isLoading.value=false;
        //bypassing user to mainscr

      }
      else {
        loginController.isLoading.value=false;
        AppServices.showSnackBar(SnackBarType.error, "Login Failed");
      }
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error,e.toString());
    }
  }

  Future<void> loginUser(String email,String pass) async {
    try{
      loginController.isLoading.value=true;
      final AuthResponse response=await supabase.auth.signInWithPassword(email: email,password: pass);
      if(response.user!=null && response.session!=null){
      loginController.isLoading.value=false;
      }
      else{
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error,"Login Failed");
      }
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error,e.toString());
    }

  }

  Future<void> signupUser(String firstName,String lastName,String email,String pass) async{
    try{
      log("sign up called");
    loginController.isLoading.value=true;
      final AuthResponse response=await supabase.auth.signUp(email: email,password: pass,data: {
        'first_name': firstName,
        'last_name': lastName,
      });
      if (response.user != null) {
        await supabase.auth.signOut(); // 👈 kill session
        AppServices.showSnackBar(SnackBarType.success,"Registered Successfully");
        loginController.isLoading.value=false;
        Get.offAllNamed(LoginScreen.route);
      }
      else{
        loginController.isLoading.value=false;
        AppServices.showSnackBar(SnackBarType.error,"Sign Up Failed");
      }
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error,e.toString());
    }

  }

  Future<bool> requestResetPassword(String email) async {
    try {
      loginController.isLoading.value=true;
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,redirectTo: 'notenest://password-reset');
      loginController.isLoading.value=false;
      return true;
    } catch (e) {
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
      return false;
    }
  }

  Future<void> resetPassword(String pass) async {
    try {
      loginController.isLoading.value=true;
      final session = supabase.auth.currentSession;
      if (session == null) {
        loginController.isLoading.value=false;
        AppServices.showSnackBar(SnackBarType.info, "Session expired or invalid reset link");
        return;
      }
      final response = await supabase.auth.updateUser(UserAttributes(password: pass));
      if (response.user != null) {
        loginController.isLoading.value=false;
        AppServices.showSnackBar(SnackBarType.success, "Password updated successfully");
      } else {
        loginController.isLoading.value=false;
        AppServices.showSnackBar(SnackBarType.error, "Failed to update password");
      }
    } catch (e)
    {
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }

  Future<void> updateAccount(String firstName,String lastName) async{
    try{
      loginController.isLoading.value=true;
      await supabase.auth.updateUser(UserAttributes(
          data: {
        'first_name':firstName,
        'last_name':lastName
      }));
      loginController.isLoading.value=false;
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }

  Future<void> deleteAccount()async{
    //this function deletes data from public table profiles
    try{
      loginController.isLoading.value=true;
      log("user id :${supabase.auth.currentUser!.id}");
      await supabase.from("profiles").delete().eq("id", supabase.auth.currentUser!.id);
      supabase.auth.signOut();
      loginController.isLoading.value=false;
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }

  Future<void> addNewTask(TaskModel taskModel)async{
    try{loginController.isLoading.value=true;
     await supabase.from("tasks").insert(taskModel.toJson()).select();
    loginController.isLoading.value=false;
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }

  Future<void> deleteTask(int id)async{
    try{loginController.isLoading.value=true;
      await supabase.from("tasks").delete().eq("id", id).select();
      loginController.isLoading.value=false;
    }
    catch(e){
      loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }

  Future<void> updateTask(TaskModel taskModel)async{
    try{
      loginController.isLoading.value=true;
      await supabase.from("tasks").update(taskModel.toJson()).eq('id', '${taskModel.id}').select();
      loginController.isLoading.value=false;
    }
    catch(e){loginController.isLoading.value=false;
      AppServices.showSnackBar(SnackBarType.error, e.toString());
    }
  }
/*
replced this code with stream in HomeController
Future<void> fetchTasks()async{
  try{
    loginController.isLoading.value=false;
    final response=await supabase.from("tasks").select();
    final tempList=response.map((e) =>TaskModel.fromJson(e)).toList();
    homeController.taskList.value=tempList;
    loginController.isLoading.value=false;
  }
  catch(e){
    loginController.isLoading.value=false;
    AppServices.showSnackBar(SnackBarType.error, e.toString());
  }

}*/
}