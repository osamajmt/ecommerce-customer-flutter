
import 'package:ecommerce_app/controller/auth/forgetpassword_controller.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:ecommerce_app/view/widget/auth/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text("130".tr), // Forgot Password
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: controller.formstate,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Text(
                "131".tr, // Verify Your Email
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "132".tr,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              AuthTextFormField(
                isNumber: false,
                controller: controller.emailController,
                hintText: "Email",
                label: "Email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              CustomSignButton(
                action: "133".tr, // Check
                onPressed: controller.checkEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}








