import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:flutter/material.dart';


//Engilsh
ThemeData englishTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primaryColor,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColor.backgroundColor,
  cardColor: Colors.white,
  dividerColor: Colors.grey.shade300,
  iconTheme: const IconThemeData(color: AppColor.primaryColor),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[50],
    foregroundColor: AppColor.primaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  ),
  fontFamily: 'cairo',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    bodyMedium: TextStyle(fontSize: 17, color: Colors.grey.shade700,),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey.shade700,),
  ),
);


//Arabic
ThemeData arabicTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primaryColor,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColor.backgroundColor,
  cardColor: Colors.white,
  dividerColor: Colors.grey.shade300,
  iconTheme: const IconThemeData(color: AppColor.primaryColor),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[50],
    foregroundColor: AppColor.primaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  ),
  fontFamily: 'cairo',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
     bodyMedium: TextStyle(fontSize: 17, color: Colors.grey.shade700,),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey.shade700,),
  ),
);


// Dark theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primaryColor,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color(0xFF1E1E1E),
  canvasColor: const Color(0xFF121212),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
  ),

  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.white, fontSize: 25),
    headlineMedium: TextStyle(color: Colors.white, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 17),
    bodySmall: TextStyle(color: Colors.white60, fontSize: 15),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  dividerColor: Colors.white12,
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white54),
    labelStyle: TextStyle(color: Colors.white70),
  ),
  fontFamily: 'cairo',
);

















