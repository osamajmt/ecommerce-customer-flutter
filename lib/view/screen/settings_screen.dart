
import 'package:ecommerce_app/controller/settings_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/localization/changelocal.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(settingsControllerImp());

    return Scaffold(
      appBar: AppBar(title: Text("89".tr), centerTitle: true, elevation: 0),
      body: ListView(
        children: [
          header(context),

          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  tile(
                    context,
                    title: "92".tr,
                    icon: Icons.person_outline,
                    onTap: () => Get.toNamed(appRoute.userProfile),
                  ),
                  tile(
                    context,
                    title: "93".tr,
                    icon: Icons.dark_mode_outlined,
                    trailing: GetBuilder<LocalController>(
                      builder:
                          (local) => Switch(
                            value: local.isDarkMode,
                            onChanged: local.toggleDarkMode,
                          ),
                    ),
                  ),
                  divider(),
                  tile(
                    context,
                    title: "67".tr,
                    icon: Icons.shopping_bag_outlined,
                    onTap: () => Get.toNamed(appRoute.pendingOrders),
                  ),
                  divider(),

                  tile(
                    context,
                    title: "68".tr,
                    icon: Icons.archive_outlined,
                    onTap: () => Get.toNamed(appRoute.archivedOrders),
                  ),
                  divider(),

                  tile(
                    context,
                    title: "148".tr,
                    icon: Icons.location_on_outlined,
                    onTap: () => Get.toNamed(appRoute.addressView),
                  ),
                  divider(),
                  tile(
                    context,
                    title: "94".tr,
                    icon: Icons.language,
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: Get.locale?.languageCode,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: "en", child: Text("English")),
                          DropdownMenuItem(value: "ar", child: Text("العربية")),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            Get.find<LocalController>().chageLang(value);
                          }
                        },
                      ),
                    ),
                  ),
                  divider(),
                  tile(
                    context,
                    title: "12".tr,
                    icon: Icons.info,
                    onTap: () => Get.toNamed(appRoute.aboutus),
                  ),
                  divider(),
                  tile(
                    context,
                    title: "13".tr,
                    icon: Icons.support_agent_outlined,
                    onTap: () => Get.toNamed(appRoute.contact),
                  ),
                  divider(),
                  tile(
                    context,
                    title: "96".tr,
                    icon: Icons.logout,
                    color: Colors.redAccent,
                    onTap: () {
                      Get.defaultDialog(
                        title: "Confirm",
                        middleText: "Are you sure you want to logout?",
                        onConfirm: controller.logout,
                        onCancel: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return GetBuilder<settingsControllerImp>(
      builder: (controller) {
        if (controller.statusRequest == StatusRequest.loading) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                backgroundImage:
                    controller.image != null
                        ? NetworkImage(
                          "${AppLink.usersImages}/${controller.image}",
                        )
                        : null,
                child:
                    controller.image == null
                        ? const Icon(Icons.person, size: 40, color: Colors.grey)
                        : null,
              ),

              const SizedBox(height: 10),
              Text(
                controller.userName ?? "Geust",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),

              Text(
                controller.userEmail ?? "",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget tile(
    BuildContext context, {
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    Widget? trailing,
    Color? color,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget divider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Divider(height: 1),
  );
}
