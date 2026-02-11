import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/orderdata.dart';
import 'package:get/get.dart';

class ArchivedOrdersController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  Services myServices = Get.find();
  List archivedOrders = [];
  int? userId;
  String printOrderType(int val) {
    if (val == 0) {
      return "By hand";
    } else {
      return "Delivery";
    }
  }

  String prtintPaymentMethod(int val) {
    if (val == 0) {
      return "Cash";
    } else {
      return "Payment card";
    }
  }

  String printOrderStatus(int val) {
    if (val == 0) {
      return "Pending";
    } else {
      return "Archived";
    }
  }

  getArchievedOrders(int userId) async {
    archivedOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await orderData.getArchivedOrders(userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          archivedOrders.addAll(response['orders']);
        } else {
          Get.defaultDialog(title: 'Warning', middleText: "  not valid");
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

  submitRating(int orderId, double rating, String comment) async {
    // statusRequest = StatusRequest.loading;
    // update();
    var response = await orderData.rateOrder(orderId, comment, rating);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
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
void onInit() async {
  await getUserId();
  getArchievedOrders(userId!);
  super.onInit();
}
}
