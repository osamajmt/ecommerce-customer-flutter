
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> exitAlert() async {
  final result = await Get.dialog<bool>(
    AlertDialog(
      
      title: const Text("Alert"),
      content: const Text("Do you want to exit the app?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("Confirm"),
        ),
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text("Cancel"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
  
  return result ?? false;
}