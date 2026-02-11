import 'package:ecommerce_app/core/localization/changelocal.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/view/widget/language/customlangbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Language extends GetView<LocalController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "1".tr,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),
                // Language buttons
                CustomLangButton(
                  textButton: "العربية",
                  icon: Icons.language,
                  onPressed: () {
                    controller.chageLang("ar");
                    Get.toNamed(appRoute.onboarding);
                  },
                ),
                const SizedBox(height: 20),
                CustomLangButton(
                  textButton: "English",
                  icon: Icons.language_outlined,
                  onPressed: () {
                    controller.chageLang("en");
                    Get.toNamed(appRoute.onboarding);
                  },
                ),

                const SizedBox(height: 50),
                Text(
                  "Choose your preferred language",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
