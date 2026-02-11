import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/view/widget/cart/cartmessagecard.dart';
import 'package:ecommerce_app/view/widget/cart/customcartbottombar.dart';
import 'package:ecommerce_app/view/widget/cart/customcartitemslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());

    return Scaffold(
      appBar: AppBar(title: Text("156".tr), centerTitle: true),
      bottomNavigationBar: GetBuilder<CartControllerImp>(
        builder: (controller) {
          final cart = controller.cart;
          return CustomCartBottomBar(
            price:
                cart.isEmpty ? "0" : cart[0]['total_price']?.toString() ?? "0",
            couponDiscount: "${controller.couponDiscount.toString()}%",
            shipping:
                cart.isEmpty
                    ? "0"
                    : cart[0]['shipping_cost']?.toString() ?? "0",
            totalPrice: controller.getTotalPrice().toString(),
            totalPriceWithShipping: cart.isEmpty
            ? "0"
            : (controller.getTotalPrice() + controller.shippingCost).toString(),
            // totalPriceWithShipping: cart.isEmpty
            // ? "0"
            // : (controller.getTotalPrice() + cart[0]['shipping_cost']).toString(),

            couponController: controller.couponController,
            onCouponApply: controller.checkCoupon,
          );
        },
      ),
      body: GetBuilder<CartControllerImp>(
        builder:
            (controller) => Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    CartMessageCard(
                      messge:
                          controller.cartItems.isEmpty
                              ? "157".tr
                              : "${"158".tr} ${controller.cart[0]['total_count']}",
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child:
                          controller.statusRequest == StatusRequest.success && controller.cartItems.isEmpty 
                              ? Center(child: Text("159".tr))
                              :controller.statusRequest == StatusRequest.loading?
                              Center(child: Lottie.asset(
                                'assets/lotties/loading_spinner.json',
                                width: 150,
                                height: 150,
                                repeat: true
                              ),)
                              : ListView.builder(
                                itemCount: controller.cartItems.length,
                                itemBuilder: (context, index) {
                                  final item = controller.cartItems[index];
                                  return CustomCartItmesList(
                                    name: item['name'] ?? "160".tr,
                                    price: (item['price'] ?? 0).toDouble(),
                                    image: item['image'] ?? "",
                                    itemId: item['item_id'],
                                  );
                                },
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
