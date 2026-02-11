
import 'package:flutter/material.dart';
class CartPaymentMethod extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isActive;
  final bool enabled; 

  const CartPaymentMethod({
    super.key,
    required this.name,
    required this.icon,
    required this.isActive,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: IgnorePointer( 
        ignoring: !enabled,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? theme.colorScheme.secondary.withOpacity(0.1)
                : theme.cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isActive
                  ? theme.colorScheme.secondary
                  : theme.dividerColor,
              width: 1.6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: enabled
                    ? (isActive
                        ? theme.colorScheme.secondary
                        : Colors.grey[600])
                    : Colors.grey,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(
                  color: enabled
                      ? (isActive
                          ? theme.colorScheme.secondary
                          : theme.textTheme.bodyMedium!.color)
                      : Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              if (isActive && enabled)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
              if (!enabled)
                const Text(
                  "Soon",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
            ],
          ),
        ),
      ),
    );
  }
}
