
import 'package:ecommerce_app/controller/checkout_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/view/widget/checkout/customCartDeliveryType.dart';
import 'package:ecommerce_app/view/widget/checkout/customCartPaymentMethod.dart';
import 'package:ecommerce_app/view/widget/checkout/customCartShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    return Scaffold(
      appBar: AppBar(title: Text("161".tr), centerTitle: true),

      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(15),
        child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: controller.checkout,
          child: Text(
            "162".tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: GetBuilder<CheckoutController>(
        builder:
            (controller) => Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Payment Method
                    Text(
                      "163".tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () => controller.choosePaymentMethod(0),
                      child: CartPaymentMethod(
                        name: "164".tr,
                        icon: Icons.money_rounded,
                        isActive: controller.paymentMethod == 0,
                        enabled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: null,
                      child: CartPaymentMethod(
                        name: "165".tr,
                        icon: Icons.credit_card_rounded,
                        isActive: controller.paymentMethod == 1,
                        enabled: false,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Delivery Type
                    Text(
                      "166".tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => controller.chooseDeliveryMethod(0),
                          child: CartDeliveryType(
                            icon: Icons.store_rounded,
                            name: "167".tr,
                            isActive: controller.type == 0,
                          ),
                        ),
                        InkWell(
                          onTap: () => controller.chooseDeliveryMethod(1),
                          child: CartDeliveryType(
                            icon: Icons.local_shipping_rounded,
                            name: "168".tr,
                            isActive: controller.type == 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    /// Shipping Address
                    if (controller.type == 1) ...[
                      Text(
                        "169".tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),

                      controller.addresses.isEmpty
                          ? Column(
                            children: [
                              Text(
                                "170".tr,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => Get.toNamed(appRoute.addressAdd),
                                child: Text(
                                  "171".tr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Column(
                            children: [
                              ...List.generate(
                                controller.addresses.length,
                                (index) => InkWell(
                                  onTap:
                                      () => controller.chooseAddressId(
                                        controller.addresses[index]['id'],
                                      ),
                                  child: CartShippingAddress(
                                    title:
                                        controller.addresses[index]['name'] ??
                                        '',
                                    subtitle:
                                        controller.addresses[index]['city'] ??
                                        '',
                                    isActive:
                                        controller.addressId ==
                                        controller.addresses[index]['id'],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => Get.toNamed(appRoute.addressAdd),
                                child: Text(
                                  "172".tr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
