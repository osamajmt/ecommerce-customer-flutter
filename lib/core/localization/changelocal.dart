import 'package:ecommerce_app/constant/apptheme.dart';
import 'package:ecommerce_app/core/function/fcmconfig.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? language;
  Services services = Get.find();

  ThemeData appTheme = englishTheme;
  bool isDarkMode = false;

 
  chageLang(String langCode) {
    Locale locale = Locale(langCode);
    services.sharedPreferences.setString("lang", langCode);

    if (isDarkMode) {
      appTheme = darkTheme;
    } else {
      appTheme = langCode == 'ar' ? arabicTheme : englishTheme;
    }

    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  
  toggleDarkMode(bool value) {
    isDarkMode = value;
    services.sharedPreferences.setBool("darkMode", value);

    if (value) {
      appTheme = darkTheme;
    } else {
      String lang = services.sharedPreferences.getString("lang") ?? "en";
      appTheme = lang == 'ar' ? arabicTheme : englishTheme;
    }

    Get.changeTheme(appTheme);
    update();
  }

  
  requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    bool isPermissionAskedBefore =
        services.sharedPreferences.getBool("location_permission_asked") ?? false;

    permission = await Geolocator.checkPermission();

    if (isPermissionAskedBefore) {
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Sorry, you can't use the app without location permission",
          "Alert",
        );
      }
      return;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Please turn on location", "Alert");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Please give location permission", "Alert");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Sorry, you can't use app without location permission",
        "Alert",
      );
    }

    services.sharedPreferences.setBool("location_permission_asked", true);
  }

 
  @override
  void onInit() {
    requestNotiPermission();
    fcmconfig();
    requestLocationPermission();

    String? lang = services.sharedPreferences.getString("lang");
    isDarkMode = services.sharedPreferences.getBool("darkMode") ?? false;

    if (lang == "ar") {
      language = const Locale("ar");
      appTheme = isDarkMode ? darkTheme : arabicTheme;
    } else {
      language = const Locale("en");
      appTheme = isDarkMode ? darkTheme : englishTheme;
    }

    super.onInit();
  }
}





