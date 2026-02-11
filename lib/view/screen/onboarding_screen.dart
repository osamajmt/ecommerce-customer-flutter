
import 'package:ecommerce_app/controller/onboarding_controller.dart';
import 'package:ecommerce_app/view/widget/onboarding/customButton.dart';
import 'package:ecommerce_app/view/widget/onboarding/customdotcontroller.dart';
import 'package:ecommerce_app/view/widget/onboarding/customslider.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3, child: CustomSlider()),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CustomDotController(),
                  CustomButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


