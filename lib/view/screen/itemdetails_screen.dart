import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/controller/item_details_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/view/widget/productdetails/custompriceandamount.dart';
import 'package:ecommerce_app/view/widget/productdetails/productdetailstop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductDetails extends GetView<ProductDetailsControllerImp> {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 60,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          color: Theme.of(context).colorScheme.primary,
          elevation: 3,
          onPressed: () {
            Get.delete<CartControllerImp>();
            Get.toNamed("cart");},
          child: Text(
            "152".tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GetBuilder<ProductDetailsControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_spinner.json',
                width: 150,
                height: 150,
                repeat: false,
              ),
            );
          }

          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const ProductDetailsTop(),
                const SizedBox(height: 100),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40),
                      bottom: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        controller.itemsModel.name ?? '',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      /// Price + Amount
                      CustomPriceAndAmount(
                        price:
                            controller.itemsModel.discountPrice == null
                                ? "${controller.itemsModel.price}\$"
                                : "${controller.itemsModel.discountPrice}\$",
                        onAddPressed: controller.add,
                        onRemovePressed: controller.remove,
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      Text(
                        controller.itemsModel.desc ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
