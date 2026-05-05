import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/controller/home_controller.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/data_models/task_model.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/page/auth/reset_password_scr.dart';

class AuthServices {
  final supabase = Supabase.instance.client;
  final authController=Get.put(LoginController());
  final homeController=Get.put(HomeController());


  Future<void> loginUser(String email,String pass) async {
    try{
      final AuthResponse response=await supabase.auth.signInWithPassword(email: email,password: pass);
      if(response.user!=null && response.session!=null){
        authController.isLoading.value=false;
      }
      else{
        Get.snackbar("Error","Login Failed");
      }
    }
    catch(e){
      Get.snackbar("Login Exception",e.toString());
    }

  }
  Future<void> signupUser(String firstName,String lastName,String email,String pass) async{
    try{
      log("sign up called");

      final AuthResponse response=await supabase.auth.signUp(email: email,password: pass,data: {
        'first_name': firstName,
        'last_name': lastName,
      });

      if (response.user != null) {
        await supabase.auth.signOut(); // 👈 kill session
        Get.snackbar("Registered Successfully", "");
        Get.offAllNamed(LoginScreen.route);
      }
      else{
        Get.snackbar("Error","Sign Up Failed");
      }
    }
    catch(e){
      authController.isLoading.value=false;
      Get.snackbar("signUp Exception",e.toString());
    }

  }

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
  Future<void> RequestResetPassword(String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,redirectTo: 'notenest://password-reset',
      );

    } catch (e) {
      Get.snackbar("Request Reset Password", e.toString());
      rethrow;
    }
  }

  Future<void> resetPassword(String pass) async {
    try {

      final session = supabase.auth.currentSession;

      if (session == null) {
        Get.snackbar("Error", "Session expired or invalid reset link");
        return;
      }

      final response = await supabase.auth.updateUser(
        UserAttributes(password: pass),
      );

      if (response.user != null) {
        Get.snackbar("Success", "Password updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update password");
      }
    } catch (e)
    {
      Get.snackbar("Reset Pass", e.toString());
    }
  }

  Future<void> continuewithGoogle() async {
    try {
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
        authController.isLoading.value = false;
        //bypassing user to mainscr

      }
      else {
        authController.isLoading.value = false;
        Get.snackbar("Error", "Login Failed");
      }
    }
    catch(e){
      Get.snackbar("Google Exception",e.toString());
    }
  }

  Future<void> updateAccount(String firstName,String lastName) async{
    try{
      log("$firstName$lastName");
      final response=await supabase.auth.updateUser(UserAttributes(
          data: {
        'first_name':firstName,
        'last_name':lastName
      }));
      log("Response updated things ${response.user!.userMetadata}");
    }
    catch(e){
      Get.snackbar("Update Account", e.toString());
    }
  }
  Future<void> deleteAccount()async{
    //this function deletes data from public table profiles
    try{
      log("user id :${supabase.auth.currentUser!.id}");
      await supabase.from("profiles").delete().eq("id", supabase.auth.currentUser!.id);
      supabase.auth.signOut();
    }
    catch(e){
      Get.snackbar("Delete Account Exception", e.toString());
    }
  }

  Future<void> fetchTasks()async{
    try{
      final response=await supabase.from("tasks").select();
      final tempList=response.map((e) =>TaskModel.fromJson(e)).toList();
      homeController.taskList.value=tempList;
    }
    catch(e){
      Get.snackbar("Fetch Task Exception", e.toString());
    }

  }

  Future<void> addNewTask(TaskModel taskModel)async{
    try{
     final response=await supabase.from("tasks").insert(taskModel.toJson()).select();
      log("inserted item $response");
    }
    catch(e){
      log("error ${e.toString()}");
      Get.snackbar("Add Task Exception", e.toString());
    }
  }
  Future<void> deleteTask(int id)async{
    try{
      final response=await supabase.from("tasks").delete().eq("id", id).select();
    }
    catch(e){
      Get.snackbar("Delete Task Exception", e.toString());
    }
  }

  Future<void> updateTask(TaskModel taskModel)async{
    try{
      log("task model ${taskModel.toJson()} ${taskModel.id}");
      final response=await supabase.from("tasks").update(taskModel.toJson()).eq('id', '${taskModel.id}').select();
      log("updated item $response");
    }
    catch(e){
      Get.snackbar("Update Task Exception", e.toString());
    }
  }




}