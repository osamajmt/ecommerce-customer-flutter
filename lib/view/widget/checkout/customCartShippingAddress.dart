
import 'package:flutter/material.dart';

class CartShippingAddress extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isActive;

  const CartShippingAddress({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isActive ? theme.colorScheme.secondary : theme.dividerColor,
          width: 1.4,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        title: Text(
          title,
          style: TextStyle(
            color:
                isActive
                    ? theme.colorScheme.secondary
                    : theme.textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isActive ? theme.colorScheme.secondary : Colors.grey[700],
            fontSize: 14,
          ),
        ),
        trailing:
            isActive
                ? Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.secondary,
                  size: 20,
                )
                : null,
      ),
    );
  }
}


