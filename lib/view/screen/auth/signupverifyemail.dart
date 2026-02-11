import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/auth/signupverifyemail_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignupVerifyEmail extends StatelessWidget {
  const SignupVerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupVerifyEmailControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Verify Your Email",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.grey),
        ),
      ),
      body: GetBuilder<SignupVerifyEmailControllerImp>(
        builder: (controller) => Form(key: controller.formstate,
        child: Container(
          color: AppColor.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Text(
                "Check Your Email",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter the 5-digit code sent to ${controller.email}",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              OtpTextField(
                numberOfFields: 5,
                borderRadius: BorderRadius.circular(23),
                borderColor: AppColor.primaryColor,
                showFieldAsBox: true,
                onCodeChanged: (_) {},
                onSubmit: (verificationCode) {
                  controller.checkCode(verificationCode);
                },
              ),
              const SizedBox(height: 20),
              CustomSignButton(
                action: "Resend Code",
                onPressed: controller.resendCode,
              ),
              if (controller.statusRequest == StatusRequest.loading)
                 Center(child: Lottie.asset(
                        'assets/lotties/loading_spinner.json',
                        width: 150,
                        height: 150,
                       repeat: true
                      ),),
            ],
          ),
        ), )
      ),
    );
  }
}
