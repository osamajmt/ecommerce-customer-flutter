
import 'package:ecommerce_app/controller/auth/resetpassword_controller.dart';
import 'package:ecommerce_app/core/function/validateinput.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:ecommerce_app/view/widget/auth/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text("134".tr), // Reset Password
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: controller.formstate,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Text(
                "135".tr,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "136".tr,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              AuthTextFormField(
                isNumber: false,
                valid: (val) => validInput(val!, 6, 20, "password"),
                controller: controller.passwordController,
                hintText: "137".tr,
                label: "Password",
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 20),
              CustomSignButton(
                action: "50".tr, // Save
                onPressed: controller.checkPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}






