import 'package:ecommerce_app/controller/user_profile_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserProfileControllerImp());
    return Scaffold(
      appBar: AppBar(title: Text("111".tr), centerTitle: true),
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
              child: GetBuilder<UserProfileControllerImp>(
                builder: (controller) {
                  if (controller.statusRequest == StatusRequest.loading) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Column(
                    children: [
                      infoTile(
                        context,
                        title: "182".tr,
                        value: controller.userName ?? "Geust",
                        icon: Icons.account_circle,
                      ),
                      const Divider(),
                      infoTile(
                        context,
                        title: "183".tr,
                        value: controller.userEmail ?? "_",
                        icon: Icons.email,
                      ),
                      const Divider(),
                      infoTile(
                        context,
                        title: "112".tr,
                        value: controller.role ?? "—",
                        icon: Icons.work,
                      ),
                      const Divider(),
                      infoTile(
                        context,
                        title: "114".tr,
                        value: "115".tr,
                        icon: Icons.check_circle,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(value),
    );
  }
}

Widget header(BuildContext context) {
  return GetBuilder<UserProfileControllerImp>(
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
            GestureDetector(
              onTap: () async {
                final controller = Get.find<UserProfileControllerImp>();
                await controller.pickImage();

                if (controller.pickedImage != null) {
                  controller.updateImage();
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        "${AppLink.usersImages}/${controller.image}",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        cacheWidth: 200,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.edit,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
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
