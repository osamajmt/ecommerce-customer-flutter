import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/order/pending_orders_controller.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrdersController());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text("67".tr), centerTitle: true, elevation: 0),
      body: GetBuilder<PendingOrdersController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_spinner.json',
                width: 150,
                height: 150,
              ),
            );
          }

          if (controller.statusRequest == StatusRequest.success &&
              controller.pendingOrders.isEmpty) {
            return Center(
              child: Text(
                "70".tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          } 

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: controller.pendingOrders.length,
            itemBuilder: (context, i) {
              final order = controller.pendingOrders[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "73".tr,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " #${order['id']}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            Jiffy(order['created_at'], 'yyyy-MM-dd').fromNow(),
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                      InfoText(
                        "74".tr,
                        controller.printOrderType(order["type"]),
                        context,
                      ),
                      InfoText(
                        "75".tr,
                        controller.prtintPaymentMethod(order['payment_method']),
                        context,
                      ),
                      InfoText(
                        "76".tr,
                        controller.printOrderStatus(order['status']),
                        context,
                      ),
                      const SizedBox(height: 8),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$${order['total_price']}",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Button(
                                "78".tr,
                                Icons.receipt_long,
                                () => Get.toNamed(
                                  appRoute.orderDetails,
                                  arguments: {"orderData": order},
                                ),
                              ),
                              const SizedBox(width: 10),
                              order['status'] != 0
                                  ? SizedBox(width: 2)
                                  : Button(
                                    "23".tr,
                                    Icons.delete_outline,
                                    () {
                                      controller.deleteOrder(order['id']);
                                      controller.refreshPage();
                                    },
                                    background: Colors.redAccent,
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget InfoText(String title, String value, dynamic context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          text: "$title ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Button(
    String text,
    IconData icon,
    VoidCallback onPressed, {
    Color? background,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: background ?? AppColor.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
