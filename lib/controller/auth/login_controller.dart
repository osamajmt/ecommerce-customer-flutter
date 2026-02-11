import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/logindata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LogInController extends GetxController {
  LoginData loginData = LoginData(Get.find());
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool showPassword = true;
  late StatusRequest? statusRequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Services myServices = Get.find();
  
  login();
  goToSignup();
  goToForgetPassword();
  unShowPassword();
}

class LogInControllerImp extends LogInController {
  @override
  login() async {
    var formdata = formstate.currentState;
    try {
      if (formdata!.validate()) {
        print("valid");
        statusRequest = StatusRequest.loading;
        if (isClosed) return; 
        update();
        var response = await loginData.login(
          emailController.text,
          passwordController.text,
        );
        if (isClosed) return;
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            if (response['user']['approval'] == 1) {
               String token = response['token'];   
              await myServices.secureStorage.write(key: "token", value: token);
               await myServices.secureStorage.write(key: "user_id", value: response['user']['id'].toString());
              await myServices.secureStorage.write(key: "email", value: response['user']['email'] ?? "");
              await myServices.secureStorage.write(key: "role", value: response['user']['role'] ?? "");
              myServices.sharedPreferences.setString(
                "user_name",
                response['user']['user_name'] ?? "",
              );
              myServices.sharedPreferences.setString(
                "phone_number",
                response['user']['phone_number'] ?? "",
              );
                if (response['user']['image'] != null && response['user']['image'].isNotEmpty) {
                myServices.sharedPreferences.setString(
                "image",
                response['user']['image'] ?? "",
              );
            }
              myServices.sharedPreferences.setString("step", '2');
              saveTokenToServer(response['user']['id']);
              Get.offNamed(
                appRoute.homeScreen,
                arguments: {"email": response['user']['email']},
              );
              return;
            } else {
              Get.toNamed(
                appRoute.signupverifyemail,
                arguments: {"email": response['user']['email']},
              );
              return;
            }
          } else {
            Get.defaultDialog(
              title: 'Warning',
              middleText: " Email or Password is not valid",
            );
            statusRequest = StatusRequest.failure;
          }
          update();
        } else {
          statusRequest = response;
          if (statusRequest == StatusRequest.serverFailure) {
            Get.defaultDialog(
              title: 'Error',
              middleText: "Server error. Please try again later.",
            );
          } else if (statusRequest == StatusRequest.offlineFailure) {
            Get.defaultDialog(
              title: 'Error',
              middleText: "No internet connection.",
            );
          }
        }
        if (!isClosed) update();
      }
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
      if (!isClosed) update();
    }
    if (!formdata!.validate()) {
      print("not valid");
    }
  }

  Future<void> saveTokenToServer(int userId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    String? authToken = await myServices.secureStorage.read(key: "token");
    if (authToken == null) return;
    print(token);
    if (token != null) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/save-fcm-token'),
        headers: {'Authorization': 'Bearer $authToken'},
        body: {'user_id': userId.toString(), 'fcm_token': token},
      );
      if (response.statusCode == 200) {
        print("✅ Token saved successfully");
      } else {
        print("❌ Failed to save token: ${response.body}");
      }
    }
  }

 
  @override
  unShowPassword() {
    showPassword = showPassword == true ? false : true;
  }

  @override
  goToSignup() {
    Future.microtask(() => Get.offAllNamed(appRoute.signup));
  }

  @override
  goToForgetPassword() {
    Future.microtask(() => Get.toNamed(appRoute.forgetpassword));
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
    });
    statusRequest = StatusRequest.none;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
