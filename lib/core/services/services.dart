import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences sharedPreferences;
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<Services> init() async {
    await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices()async {
 await Get.putAsync(() => Services().init());
}
