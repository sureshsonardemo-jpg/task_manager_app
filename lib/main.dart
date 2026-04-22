import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/view/page/auth/forgot_password_screen.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/page/auth/signup_screen.dart';
import 'package:task_manager_app/view/page/main/home_screen.dart';
import 'package:task_manager_app/view/page/on_boarding_screen.dart';
import 'package:task_manager_app/view/page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            color: AppColors.textTitleBlack,
            fontFamily: "BeVietnam-Pro",
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: AppColors.purple),
        ),
        scaffoldBackgroundColor: AppColors.white
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: <String, WidgetBuilder>{
        SplashScreen.route: (_) => SplashScreen(),
        OnBoardingScreen.route: (_) => OnBoardingScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        SignupScreen.route:(_) =>SignupScreen(),
        ForgotPasswordScreen.route:(_)=>ForgotPasswordScreen(),
        HomeScreen.route:(_)=>HomeScreen(),
      },
    );
  }
}
