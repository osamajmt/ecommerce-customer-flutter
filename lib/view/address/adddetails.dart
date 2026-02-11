import 'package:ecommerce_app/controller/address/add_address_details_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/view/widget/auth/customSignButton.dart';
import 'package:ecommerce_app/view/widget/auth/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetailsAdd extends StatelessWidget {
  const AddressDetailsAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddAddressDetailsController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("169".tr),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: GetBuilder<AddAddressDetailsController>(
          builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: ListView(
              children: [
                const SizedBox(height: 10),

                AuthTextFormField(
                  hintText: "63".tr,
                  label: "City",
                  icon: Icons.location_city,
                  controller: controller.city!,
                  isNumber: false,
                ),

                const SizedBox(height: 20),

                AuthTextFormField(
                  hintText: "64".tr,
                  label: "Street",
                  icon: Icons.streetview,
                  controller: controller.street!,
                  isNumber: false,
                ),

                const SizedBox(height: 20),

                AuthTextFormField(
                  hintText: "61".tr,
                  label: "Name",
                  icon: Icons.home_work_outlined,
                  controller: controller.name!,
                  isNumber: false,
                ),

                const SizedBox(height: 30),

                CustomSignButton(
                  action: "49".tr,
                  onPressed: controller.addAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


