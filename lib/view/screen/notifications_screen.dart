
import 'package:ecommerce_app/controller/notifications_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text("29".tr), // Notifications
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GetBuilder<NotificationsControllerImp>(
          builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: controller.statusRequest == StatusRequest.success &&  controller.notifications.isEmpty
                ? Center(
                    child: Text(
                      "118".tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                   :controller.statusRequest == StatusRequest.loading?
                    Lottie.asset(
                      'assets/lotties/loading_spinner.json',
                      width: 150,
                      height: 150,
                      repeat: true
                    )
                : ListView.separated(
                    itemCount: controller.notifications.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final notification = controller.notifications[i];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              child: Icon(
                                Icons.notifications_active,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['title'] ?? "119".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['body'] ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                  const SizedBox(height: 6),
                                 Text(
                                notification['created_at'] != null
                                    ? Jiffy(notification['created_at']).fromNow()
                                    : "",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}





