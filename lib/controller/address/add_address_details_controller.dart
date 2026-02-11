import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/addressdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddAddressDetailsController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.none;
  int? userId;
  String? lat;
  String? long;
  AddressData addressData = AddressData(Get.find());
  Services myServices = Get.find();
  TextEditingController? name;
  TextEditingController? city;
  TextEditingController? street;

  addAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.addAddress(
      city!.text,
      name!.text,
      street!.text,
      lat!,
      long!,
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offNamed(appRoute.homeScreen);
        Get.snackbar("title", "You can now order with this address");
      } else {
        Get.defaultDialog(title: 'Warning', middleText: "invalid");
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
  }

  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  void onInit() {
    name = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();

    lat = Get.arguments["lat"];
    long = Get.arguments["long"];

    getUserId();
    super.onInit();
  }
}
