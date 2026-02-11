import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/sendcodedata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  String? email;
  late TextEditingController emailController;
  late StatusRequest? statusRequest;
  SendCodeData sendCodeData = SendCodeData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  checkEmail();
  goToVerifyPage();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  @override
  checkEmail() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await sendCodeData.sendCode(emailController.text);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
           goToVerifyPage();
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: " Email  is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
    if (!formdata.validate()) {
      print("not valid");
    }
  }

  goToVerifyPage() {
    Future.microtask(
      () => Get.offAllNamed(
        appRoute.verifyemail,
        arguments: {"email": emailController.text},
      ),
    );
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
