import 'dart:async';

import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/orderdata.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailsController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  Services myServices = Get.find();
  List orderDetails = [];
  List addressDetails = [];
  int? userId;
  double? long;
  double? lat;
  Position? position;
  CameraPosition? kGooglePlex;
  List<Marker> markers = [];
  Completer<GoogleMapController>? CompleteController;
  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  getOrderData(int orderId) async {
    orderDetails.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await orderData.getOrderDetails(orderId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          orderDetails.add(response['data']);
          addressDetails.add(response['data']['address']);
          print(orderDetails);
          _initializeMap();
          // orderDetails.add(response['orders']);
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: " Email or Password is not valid",
          );
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = response;
        if (statusRequest == StatusRequest.serverFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "Server error. Please try again later.",
          );
        } else if (statusRequest == StatusRequest.offlineFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "No internet connection.",
          );
        }
      }
      update();
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  void _initializeMap() {
    if (addressDetails.isNotEmpty && orderDetails[0]['address'] != null) {
      kGooglePlex = CameraPosition(
        target: LatLng(
          double.parse(addressDetails[0]['latitude'].toString()),
          double.parse(addressDetails[0]['longitude'].toString()),
        ),
        zoom: 18.4746,
      );

      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(
            double.parse(addressDetails[0]['latitude'].toString()),
            double.parse(addressDetails[0]['longitude'].toString()),
          ),
        ),
      );
    }
  }

  @override
  void onInit() {
    Map<String, dynamic> orderData = Get.arguments['orderData'];
    getOrderData(orderData['id']);

    super.onInit();
  }
}
