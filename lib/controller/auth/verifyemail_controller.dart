import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/verifyemaildata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifyEmailController extends GetxController {
  String? email;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late StatusRequest statusRequest;

  checkCode(String verificationCode);
  resendCode();
  goToResetPassword();
}

class VerifyEmailControllerImp extends VerifyEmailController {
  VerifyEmailData verifyEmailSignupData = VerifyEmailData(Get.find());

  @override
  checkCode(String verificationCode) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await verifyEmailSignupData.verifyEmail(
      email!,
      verificationCode,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        goToResetPassword();
      } else {
        Get.defaultDialog(
          title: "Warning",
          middleText: "The verification code is not valid",
        );
        statusRequest = StatusRequest.failure;
      }
    } else {
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

  @override
  resendCode() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await verifyEmailSignupData.sendCode(email!);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        Get.snackbar("Success", "Verification code sent to your email");
      } else {
        Get.defaultDialog(
          title: "Warning",
          middleText: "Failed to resend code",
        );
        statusRequest = StatusRequest.failure;
      }
    } else {
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

  @override
  goToResetPassword() {
    Get.offAllNamed(appRoute.resetpassword, arguments: {"email": email});
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    email = Get.arguments['email'];
    super.onInit();
  }
}
