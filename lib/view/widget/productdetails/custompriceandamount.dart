
import 'package:ecommerce_app/controller/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomPriceAndAmount extends StatelessWidget {
  final void Function()? onAddPressed;
  final void Function()? onRemovePressed;
  final String price;

  const CustomPriceAndAmount({
    super.key,
    required this.price,
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<ProductDetailsControllerImp>(
      id: "cart_update",
      builder: (controller) => Row(
        children: [
          // Quantity Selector
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(Icons.remove, onRemovePressed, theme),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                     controller.itemCount.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                _buildActionButton(Icons.add, onAddPressed, theme),
              ],
            ),
          ),

          const Spacer(),

          // Price Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, void Function()? onPressed, ThemeData theme) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: theme.colorScheme.primary),
      ),
    );
  }
}

