
import 'package:ecommerce_app/controller/address/view_address_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewAddressController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text("148".tr), centerTitle: true, elevation: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        onPressed: () => Get.toNamed(appRoute.addressAdd),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GetBuilder<ViewAddressController>(
        builder:
            (controller) => Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child:
                    controller.addresses.isEmpty
                        ? Center(
                          child: Text(
                            "170".tr,
                            style: theme.textTheme.bodyMedium,
                          ),
                        )
                        : ListView.builder(
                          itemCount: controller.addresses.length,
                          itemBuilder: (context, i) {
                            final address = controller.addresses[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.dividerColor.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                title: Text(
                                  "${address['name']}",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                subtitle: Text(
                                  "${address['city']}, ${address['street']}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed:
                                      () => controller.deleteAddress(
                                        address['id'],
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ),
      ),
    );
  }
}
