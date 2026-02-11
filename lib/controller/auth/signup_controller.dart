
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/auth/signupdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  SignupData signupData = SignupData(Get.find());
  List data = [];
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late StatusRequest? statusRequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  signup();
  goToLogin();
}

class SignUpControllerImp extends SignUpController {
  @override
  signup() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print("valid");
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.register(
        userNameController.text,
        emailController.text,
        passwordController.text,
        phoneController.text,
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offAllNamed(
            appRoute.signupverifyemail,
            arguments: {"email": response['user']['email']},
          );
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: "Phone Number Or Email Address Already Exist",
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
  goToLogin() {
    Future.microtask(() => Get.offAllNamed(appRoute.login));
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
