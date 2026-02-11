
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/orderdata.dart';
import 'package:get/get.dart';

class PendingOrdersController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  Services myServices = Get.find();
  List pendingOrders = [];
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
      return "Approved";
    }
  }

  getPendingOrders(int userId) async {
    pendingOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await orderData.getPendingOrders(userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          pendingOrders.addAll(response['orders']);
        } else {
          Get.defaultDialog(title: 'Warning', middleText: " invalid");
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

  deleteOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.deleteOrder(orderId);
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

  resetPageVars() {
    print("=====================reset");
    pendingOrders.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getPendingOrders(userId!);
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
  getPendingOrders(userId!);
  super.onInit();
}
}
