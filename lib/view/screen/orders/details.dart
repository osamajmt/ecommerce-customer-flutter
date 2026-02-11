
import 'package:ecommerce_app/controller/order/order_details_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';


class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("82".tr, style:Theme.of(context).textTheme.headlineLarge,),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GetBuilder<OrderDetailsController>(
          builder: (controller) {

            if (controller.statusRequest==StatusRequest.loading) {
               return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_spinner.json',
                  width: 150,
                  height: 150,
                  repeat: true,
                ),
              );
            }
            if (controller.orderDetails.isEmpty ||
            controller.orderDetails[0]['order_data'] == null ||
            controller.orderDetails[0]['order_data'].isEmpty) {
              return Center(
                child: Text(
                  "88".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  sectionCard(
                    context,
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      children: [
                        TableRow(
                          children: [
                            tableHeader(context, "83".tr),
                            tableHeader(context, "84".tr),
                            tableHeader(context, "85".tr),
                          ],
                        ),
                        ...controller.orderDetails[0]['order_data']
                            .map<TableRow>((item) {
                          return TableRow(
                            children: [
                              tableCell(context, item['name']),
                              tableCell(
                                  context, item['count'].toString()),
                              tableCell(
                                  context, "\$${item['price']}"),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  sectionCard(
                    context,
                    child: Center(
                      child: Text(
                        "${"86".tr} \$${controller.orderDetails[0]['total_price']}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),

                  if (controller.orderDetails[0]['type'] == 1) ...[
                    const SizedBox(height: 20),

                    sectionCard(
                      context,
                      child: ListTile(
                        title: Text(
                          "87".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        subtitle: Text(
                          "${controller.addressDetails[0]['city']}, "
                          "${controller.addressDetails[0]['street']}",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 300,
                        child: GoogleMap(
                          markers: controller.markers.toSet(),
                          initialCameraPosition:
                              controller.kGooglePlex!,
                          onMapCreated: (mapController) =>
                              controller.CompleteController!
                                  .complete(mapController),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Widget sectionCard(BuildContext context, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget tableHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget tableCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}





