import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/view/widget/cart/customCartButton.dart';
import 'package:ecommerce_app/view/widget/cart/customcartcouponbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCartBottomBar extends StatelessWidget {
  final String price;
  final String couponDiscount;
  final String shipping;
  final String totalPrice;
  final String totalPriceWithShipping;
  final TextEditingController couponController;
  final VoidCallback? onCouponApply;

  const CustomCartBottomBar({
    super.key,
    required this.price,
    required this.shipping,
    required this.totalPrice,
    required this.couponController,
    this.onCouponApply,
    required this.totalPriceWithShipping,
    required this.couponDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Coupon section
          GetBuilder<CartControllerImp>(
            builder: (controller) {
              if (controller.couponName == null) {
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: couponController,
                        decoration: InputDecoration(
                          hintText: "174".tr,
                          isDense: true,
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: CustomCartCouponButton(
                        text: "175".tr,
                        onPressed: onCouponApply,
                      ),
                    ),
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "${"176".tr}: ${controller.couponName}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          /// Price summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: primary.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                _priceRow(context, "177".tr, price),
                _priceRow(context, "178".tr, couponDiscount),
                _priceRow(context, "179".tr, shipping),
                const Divider(),
                _priceRow(context, "180".tr, "\$$totalPrice", isTotal: true),
                _priceRow(
                  context,
                  "308".tr,
                  "\$$totalPriceWithShipping",
                  isTotal: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const CustomCartButton("181"),
        ],
      ),
    );
  }

  Widget _priceRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
