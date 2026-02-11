
import 'package:flutter/material.dart';

class CartDeliveryType extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool isActive;

  const CartDeliveryType({
    super.key,
    required this.icon,
    required this.name,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // access theme for colors

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 130,
      width: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:
            isActive
                ? theme.colorScheme.secondary.withOpacity(0.1)
                : theme.cardColor,
        border: Border.all(
          color: isActive ? theme.colorScheme.secondary : theme.dividerColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             Icon(
            icon,
            size: 50,
            color: isActive
                ? theme.colorScheme.secondary
                : theme.iconTheme.color,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color:
                  isActive
                      ? theme.colorScheme.secondary
                      : theme.textTheme.bodyMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
