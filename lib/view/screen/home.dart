import 'dart:io';
import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/view/widget/customappbarbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return GetBuilder<HomeControllerImp>(
      builder:
          (controller) => Scaffold(
             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                Get.toNamed(appRoute.cart);
              },
              child: const Icon(Icons.shopping_bag_outlined, size: 26),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            // 🔹 Upgraded Bottom Navigation Bar
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomAppBarButton(
                      icon: Icons.home_rounded,
                      isActive: controller.currentPage == 0,
                      onPressed: () => controller.changePage(0),
                    ),
                    CustomAppBarButton(
                      icon: Icons.local_offer_rounded,
                      isActive: controller.currentPage == 1,
                      onPressed: () => controller.changePage(1),
                    ),

                    const SizedBox(width: 40), // 👈 Space for FAB notch

                    CustomAppBarButton(
                      icon: Icons.notifications_active_outlined,
                      isActive: controller.currentPage == 2,
                      onPressed: () => controller.changePage(2),
                    ),
                    CustomAppBarButton(
                      icon: Icons.settings_rounded,
                      isActive: controller.currentPage == 3,
                      onPressed: () => controller.changePage(3),
                    ),
                  ],
                ),
              ),
            ),

            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                  Get.defaultDialog(
                      title: "24".tr,
                    middleText: "25".tr,
                    confirmTextColor: Colors.white,
                    buttonColor: Get.theme.primaryColor,
                    textConfirm: "26".tr,
                    textCancel: "27".tr,
                    onConfirm: () => exit(0),
                    onCancel: Get.back,
                  );
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.pages[controller.currentPage],
              ),
            ),
          ),
    );
  }
}
