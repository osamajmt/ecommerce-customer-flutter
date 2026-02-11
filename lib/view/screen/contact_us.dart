import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("13".tr), // Contact Us
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "186".tr, // We’d love to hear from you
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "187".tr, // Description
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 25),
            const Divider(),

            contactTile(
              context,
              icon: Icons.email_outlined,
              title: "103".tr, // Email
              value: "support@yourapp.com",
              onTap: () {
                Clipboard.setData(
                  const ClipboardData(text: "support@yourapp.com"),
                );
                Get.snackbar("188".tr, "189".tr);
              },
            ),

            contactTile(
              context,
              icon: Icons.phone_outlined,
              title: "104".tr, // Phone
              value: "+963 9XX XXX XXX",
              onTap: () {
                Clipboard.setData(
                  const ClipboardData(text: "+963 9XX XXX XXX"),
                );
                Get.snackbar("188".tr, "190".tr);
              },
            ),

            contactTile(
              context,
              icon: Icons.location_on_outlined,
              title: "191".tr, // Address
              value: "192".tr, // Syria
            ),

            const Spacer(),

            Center(
              child: Text(
                "193".tr, // Response time
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}
