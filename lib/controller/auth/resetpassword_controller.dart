import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/resetpassworddata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  String? email;
  late TextEditingController passwordController;
  late StatusRequest? statusRequest;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  checkPassword();
  goToSuccess();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  @override
  checkPassword() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print("valid");
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetPasswordData.resetPassword(
        email,
        passwordController.text,
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offAllNamed(appRoute.successresetpassword);
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: " Email or Password is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
      }
      else{
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
      update();
    }
    if (!formdata.validate()) {
      print("not valid");
    }
  }

  @override
  goToSuccess() {
    Future.microtask(() => Get.offAllNamed(appRoute.successresetpassword));
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
