import 'package:ecommerce_app/constant/imageasset.dart';
import 'package:ecommerce_app/controller/item_details_controller.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsTop extends GetView<ProductDetailsControllerImp> {
  const ProductDetailsTop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = controller.itemsModel;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background header
        Container(
          height: 260,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.8),
                theme.scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),

        // Floating product image
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Hero(
            tag: '${item.id}',
            child: Center(
              child: Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    AppLink.itemsImages + "/${item.image}",
                    fit: BoxFit.contain,
                    height: 120,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 150,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        // Discount badge
        if (item.discount! > 0)
          Positioned(
            top: 40,
            left: 25,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(ImageAsset.offer, width: 60, height: 60),
            ),
          ),
      ],
    );
  }
}
