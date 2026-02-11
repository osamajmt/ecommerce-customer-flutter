import 'dart:async';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/data/dataSource/remote/addressdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressController extends GetxController {
  List<Marker> markers = [];
  double? long;
  double? lat;
  Position? position;
  CameraPosition? kGooglePlex;
  Completer<GoogleMapController>? CompleteController;
  StatusRequest? statusRequest = StatusRequest.none;

  static const CameraPosition kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  AddressData addressData = AddressData(Get.find());
  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  goToAddAddressDetails() {
    Get.toNamed(
      appRoute.addressDetailsAdd,
      arguments: {"lat": lat.toString(), "long": long.toString()},
    );
  }

  getCurrentLocation() async {
    statusRequest = StatusRequest.loading;
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    addMarkers(LatLng(position!.latitude, position!.longitude));
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void onInit() {
    getCurrentLocation();
    CompleteController = Completer<GoogleMapController>();
    super.onInit();
  }
}
