import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/notificationsdata.dart';
import 'package:get/get.dart';

abstract class NotificationsController extends GetxController {
  Services myServices = Get.find();
  StatusRequest? statusRequest;
  int? userId;
  List notifications = [];
  getNotifications(int userID);
}

class NotificationsControllerImp extends NotificationsController {
  int currentPage = 0;
  NotificationsData notificationsData = NotificationsData(Get.find());
  @override
  getNotifications(int userId) async {
    notifications.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await notificationsData.getNotifications(userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          notifications.addAll(response['notifications']);
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

  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  void onInit() async{
    await getUserId();
    getNotifications(userId!);
    super.onInit();
  }
}
