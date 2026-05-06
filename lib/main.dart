import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/res/app_constants.dart';
import 'package:task_manager_app/res/colors.dart';
import 'package:task_manager_app/services/app_translations.dart';
import 'package:task_manager_app/view/page/auth/forgot_password_screen.dart';
import 'package:task_manager_app/view/page/auth/login_screen.dart';
import 'package:task_manager_app/view/page/auth/signup_screen.dart';
import 'package:task_manager_app/view/page/on_boarding_screen.dart';
import 'package:task_manager_app/view/page/settings/language_page.dart';
import 'package:task_manager_app/view/page/splash_screen.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANONKEY']!,
  );
  Get.put(AuthController(), permanent: true);
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String langCode=prefs.getString(AppConstants.langCode)??'en';
  runApp(MyApp( langCode: langCode,));
}

class MyApp extends StatelessWidget {

  final String langCode;

  const MyApp({super.key,required this.langCode});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale:  Locale(langCode),
      fallbackLocale: const Locale('en'),
      title: 'Flutter Demo',
      theme:ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.textTitleBlack,
            letterSpacing: 0,
            height: 1.5,
          ),
          //forgot pass
          bodySmall: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.purple,
            letterSpacing: 0,
            height: 1.5,
          ),
          //Home Screen Above Textfileds
          bodyMedium: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.textGrey,
            height: 1.5,
            letterSpacing: 0,
          ),

          //Home Screeen hinttext textfields
          bodyLarge: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.textTitleBlack,
            height: 1.5,
            letterSpacing: 0,
          ),
          //title
          titleLarge: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.textTitleBlack,
            letterSpacing: 0,
            height: 1.5,
          ),
          titleMedium: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.textTitleBlack,
            letterSpacing: 0,
            height: 1.5,
          ),
        ),
        scaffoldBackgroundColor: AppColors.white,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.red,
            side: BorderSide(color: AppColors.red),
            textStyle: GoogleFonts.beVietnamPro(
              color: AppColors.red,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
            alignment: Alignment.center,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: <String, WidgetBuilder>{
        SplashScreen.route: (_) => SplashScreen(),
        OnBoardingScreen.route: (_) => OnBoardingScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        SignupScreen.route: (_) => SignupScreen(),
        ForgotPasswordScreen.route: (_) => ForgotPasswordScreen(),
        LanguagePage.route: (_) => LanguagePage(),
      },
    );
  }
}
