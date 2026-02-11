import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/verifyemaildata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SignupVerifyEmailController extends GetxController {
  String? email;
  late TextEditingController verifyCodeController;
  late StatusRequest? statusRequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  checkCode(String verificationCode);
  goToSuccess();
  resendCode();
}

class SignupVerifyEmailControllerImp extends SignupVerifyEmailController {
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
          goToSuccess();
        } else {
          Get.defaultDialog(
            title: "Warning",
            middleText: "the Verification Code you enterd is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
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
      update();
    
  }

  @override
  goToSuccess() {
    Get.offAllNamed(appRoute.successsignup);
  }
  @override
  resendCode() async{
     if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await verifyEmailSignupData.sendCode(
        email!,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          Get.snackbar("Success", "Verification code sent to your email");
        } else {
          Get.defaultDialog(
            title: "Warning",
            middleText: "the Verification Code you enterd is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
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
      update();
    }
  }
  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    email = Get.arguments['email'];
    verifyCodeController = TextEditingController();
    super.onInit();
  }
    

  @override
  void dispose() {
    verifyCodeController.dispose();
    super.dispose();
  }
  

}
