import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/onboarding_controller.dart';
import 'package:ecommerce_app/data/dataSource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDotController extends StatelessWidget {
  const CustomDotController({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onBoardingList.length,
          (index) {
            bool active = controller.currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              height: 8,
              width: active ? 22 : 8,
              decoration: BoxDecoration(
                color: active
                    ? AppColor.primaryColor
                    : AppColor.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColor.primaryColor.withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
            );
          },
        ),
      ),
    );
  }
}

