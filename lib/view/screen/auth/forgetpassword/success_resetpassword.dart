import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/auth/successresetpassword_controller.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(successResetPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text("138".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 160,
              color: AppColor.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              "139".tr,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomSignButton(
              action: "140".tr,
              onPressed: controller.goToLogin,
            ),
          ],
        ),
      ),
    );
  }
}



