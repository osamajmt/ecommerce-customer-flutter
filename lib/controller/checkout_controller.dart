import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/addressdata.dart';
import 'package:ecommerce_app/data/dataSource/remote/orderdata.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  CartControllerImp cartController = Get.find<CartControllerImp>();
  AddressData addressData = AddressData(Get.find());
  OrderData orderData = OrderData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  Services myServices = Get.find();
  int? paymentMethod = 0;
  int? type = 0;
  int? addressId;
  int? userId;
  int? couponId;
 
  double? totalPrice;
  double? totalPriceWithoutShipping;
  double? totalPriceWithShipping;
  List addresses = [];
  choosePaymentMethod(val) {
    paymentMethod = val;
    update();
  }

  chooseDeliveryMethod(val) {
    type = val;
    update();
  }

  chooseAddressId(val) {
    addressId = val;
    update();
  }

  checkout() async {
    if (paymentMethod == null) {
      return Get.snackbar("Error", "please select a payment method");
    }
    if (type == null) {
      return Get.snackbar("Error", "please select the order type");
    }
    if (type == 1) {
      if (addressId == null) {
        return Get.snackbar("Error", "please select your address");
      }
      totalPrice = totalPriceWithShipping;
    }
    if (type == 0) {
      totalPrice = totalPriceWithoutShipping;
    }
    print("valid");
    statusRequest = StatusRequest.loading;
    update();

    var response = await orderData.checkout(
      userId!,
      addressId,
      couponId,
      type!,
      totalPrice!,
      100,
      paymentMethod!,
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        cartController.resetCartVars();
        cartController.update();
        Get.toNamed(appRoute.homeScreen);
      } else {
        Get.snackbar("Failure", "please try again later");
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

  getAddresses() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.getAddresses(userId!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        addresses.addAll(response['addresses']);
       if (addresses.isNotEmpty) {
      addressId = addresses[0]['id'];
    }
      } else {
        Get.defaultDialog(title: 'Warning', middleText: "Invalid coupon");
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
  Future<void> initCheckout() async {
    statusRequest = StatusRequest.loading;
    update();
    await getUserId();     
    await getAddresses();  
  }
  void onInit()  {
    couponId = Get.arguments['couponId'];
    totalPriceWithoutShipping = Get.arguments['totalPrice'];
    totalPriceWithShipping = Get.arguments['totalPriceWithShipping'];
    initCheckout();
    super.onInit();
  }
}
