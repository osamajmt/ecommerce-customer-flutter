import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/auth/signup_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/validateinput.dart';
import 'package:ecommerce_app/view/widget/auth/customSignAlternative.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:ecommerce_app/view/widget/auth/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpControllerImp());

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    //Title section
                    Text(
                      "Welcome to Ecommerce",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "Create an account to start your shopping journey",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // --- Form fields
                    AuthTextFormField(
                      isNumber: false,
                      valid: (val) => validInput(val!, 5, 15, "username"),
                      controller: controller.userNameController,
                      hintText: "Enter your username",
                      label: "Username",
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),

                    AuthTextFormField(
                      isNumber: false,
                      valid: (val) => validInput(val!, 8, 30, "email"),
                      controller: controller.emailController,
                      hintText: "Enter your email",
                      label: "Email",
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),

                    AuthTextFormField(
                      isNumber: true,
                      valid: (val) => validInput(val!, 8, 12, "phone"),
                      controller: controller.phoneController,
                      hintText: "Enter your phone number",
                      label: "Phone Number",
                      icon: Icons.phone_outlined,
                    ),
                    const SizedBox(height: 20),

                    AuthTextFormField(
                      isNumber: false,
                      valid: (val) => validInput(val!, 6, 15, "password"),
                      controller: controller.passwordController,
                      hintText: "Enter your password",
                      label: "Password",
                      icon: Icons.lock_outline,
                      isObscure: true,
                    ),

                    const SizedBox(height: 30),

                    // Sign Up Button
                    CustomSignButton(
                      action: "Create Account",
                      onPressed: controller.signup,
                    ),

                    if (controller.statusRequest == StatusRequest.loading)
                       Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Lottie.asset(
                          'assets/lotties/loading_spinner.json',
                          width: 150,
                          height: 150,
                        repeat: true
                        ),
                        ),
                      )
                    else
                      CustomSignAlternative(
                        action: " Log In",
                        state: "Already registered?",
                        onTap: () => controller.goToLogin(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}





