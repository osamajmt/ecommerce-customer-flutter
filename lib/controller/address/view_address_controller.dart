import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/addressdata.dart';
import 'package:get/get.dart';

class ViewAddressController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.none;
  int? userId;
  List addresses = [];
  AddressData addressData = AddressData(Get.find());
  Services myServices = Get.find();
  getAddress(int userId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.getAddresses(userId);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        addresses.addAll(response['addresses']);
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

  deleteAddress(int addressId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.deleteAddress(addressId);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getAddress(userId!);
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
  void onInit() async{
    await getUserId();
    getAddress(userId!);
    super.onInit();
  }
}
