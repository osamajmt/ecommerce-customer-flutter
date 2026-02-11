import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("12".tr), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "200".tr, // Dara
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

           
            Text(
              "201".tr,
              style: theme.textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

            
            sectionTitle(context, "202".tr),
            sectionText(context, "203".tr),

            const SizedBox(height: 20),

           
            sectionTitle(context, "204".tr),
            sectionText(context, "205".tr),

            const SizedBox(height: 20),

            
            sectionTitle(context, "206".tr),
            bullet(context, "207".tr),
            bullet(context, "208".tr),
            bullet(context, "209".tr),
            bullet(context, "210".tr),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 16),

            
            sectionTitle(context, "13".tr),
            sectionText(context, "211".tr),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget sectionText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget bullet(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  "),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
