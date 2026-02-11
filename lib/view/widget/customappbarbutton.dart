import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final bool isActive;

  const CustomAppBarButton({
    super.key,
    required this.icon,
    this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        decoration: BoxDecoration(
          color:
              isActive
                  ? AppColor.primaryColor.withOpacity(0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 28,
          color: isActive ? AppColor.primaryColor : Colors.grey[600],
        ),
      ),
    );
  }
}
