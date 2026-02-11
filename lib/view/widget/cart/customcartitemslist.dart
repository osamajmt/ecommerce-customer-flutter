import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCartItmesList extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final int itemId;

  const CustomCartItmesList({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GetBuilder<CartControllerImp>(
      id: "item_$itemId", //  rebuild only this item
      builder: (controller) {
        final item = controller.cartItems.firstWhere(
          (e) => e['item_id'] == itemId,
        );

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "${AppLink.itemsImages}/$image",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$$price",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    _iconButton(
                      context,
                      Icons.add,
                      () => controller.add(itemId),
                    ),

                    Text(
                      item['count'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    _iconButton(
                      context,
                      Icons.remove,
                      () => controller.remove(itemId),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _iconButton(
  BuildContext context,
  IconData icon,
  VoidCallback onPressed,
) {
  final primary = Theme.of(context).colorScheme.primary;

  return Container(
    height: 28,
    width: 28,
    decoration: BoxDecoration(
      color: primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: IconButton(
      icon: Icon(icon, size: 16, color: primary),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
    ),
  );
}
