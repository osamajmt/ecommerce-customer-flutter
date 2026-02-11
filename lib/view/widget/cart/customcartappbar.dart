import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCartAppBar extends StatelessWidget {
  const CustomCartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Back button
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.primary,
              onPressed: Get.back,
            ),
          ),
        ),

        /// Title
        Expanded(
          flex: 4,
          child: Text(
            "173".tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}


