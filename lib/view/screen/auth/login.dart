import 'dart:io';
import 'package:ecommerce_app/controller/auth/login_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/exitalert.dart';
import 'package:ecommerce_app/core/function/validateinput.dart';
import 'package:ecommerce_app/view/widget/auth/customSignAlternative.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:ecommerce_app/view/widget/auth/logo.dart';
import 'package:ecommerce_app/view/widget/auth/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LogInControllerImp());

    return Scaffold(
      appBar: AppBar(title: Text("129".tr), centerTitle: true),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final shouldExit = await exitAlert();
          if (shouldExit) {
            Platform.isAndroid ? SystemNavigator.pop() : exit(0);
          }
        },
        child: GetBuilder<LogInControllerImp>(
          builder:
              (controller) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: controller.formstate,
                  child: ListView(
                    children: [
                      Logo(),
                      const SizedBox(height: 10),
                      Text(
                        "90".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "124".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 30),

                      AuthTextFormField(
                        controller: controller.emailController,
                        label: "103".tr,
                        hintText: "126".tr,
                        icon: Icons.email_outlined,
                        isNumber: false,
                        valid: (val) => validInput(val!, 8, 30, "email"),
                      ),

                      const SizedBox(height: 20),

                      GetBuilder<LogInControllerImp>(
                        builder:
                            (controller) => AuthTextFormField(
                              controller: controller.passwordController,
                              label: "125".tr,
                              hintText: "127".tr,
                              icon: Icons.lock_outline,
                              isObscure: controller.showPassword,
                              isNumber: false,
                              onTapIcon: controller.unShowPassword,
                              valid:
                                  (val) => validInput(val!, 6, 20, "password"),
                            ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: controller.goToForgetPassword,
                          child: Text("128".tr),
                        ),
                      ),

                      CustomSignButton(
                        action: "129".tr,
                        onPressed: controller.login,
                      ),

                      if (controller.statusRequest == StatusRequest.loading)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Lottie.asset(
                              'assets/lotties/loading_spinner.json',
                              width: 150,
                              height: 150,
                              repeat: true,
                            ),
                          ),
                        )
                      else
                        CustomSignAlternative(
                          action: " Sign Up",
                          state: "Dosn't have an account",
                          onTap: () => controller.goToSignup(),
                        ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
