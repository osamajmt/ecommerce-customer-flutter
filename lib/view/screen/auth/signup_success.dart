import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/auth/successsignupcontroller.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(successSignupControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Account Created",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.grey),
        ),
      ),
      body: Container(
        color: AppColor.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline,
                size: 160, color: AppColor.primaryColor),
            const SizedBox(height: 20),
            Text(
              "Your account has been created successfully!",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomSignButton(
              action: "Go to Login",
              onPressed: controller.goToLogin,
            ),
          ],
        ),
      ),
    );
  }
}




