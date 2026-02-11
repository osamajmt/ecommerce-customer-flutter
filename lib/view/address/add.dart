
import 'package:ecommerce_app/controller/address/add_address_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddressAdd extends StatelessWidget {
  const AddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddAddressController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("171".tr),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<AddAddressController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Column(
            children: [
              if (controller.kGooglePlex != null)
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: controller.markers.toSet(),
                          onTap: controller.addMarkers,
                          initialCameraPosition: controller.kGooglePlex!,
                          onMapCreated: (GoogleMapController mapController) {
                            controller.CompleteController!
                                .complete(mapController);
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                theme.colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 3,
                          ),
                          onPressed:
                              controller.goToAddAddressDetails,
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          label: Text(
                            "144".tr,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
