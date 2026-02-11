import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/cartdata.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  Services myServices = Get.find();
  List cart = [];
  List cartItems = [];
  int? userId;
  int itemCount = 0;
  double totalPrice = 0;
  int cartItemsCount = 0;
  var couponDiscount = 0;
  String? couponName;
  int? couponId;

  double shippingCost = 0;

  StatusRequest? statusRequest;
  TextEditingController couponController = TextEditingController();
  initialData();
  clearCart();
  getCart();
  addCart( int itemId);
  deleteCart( int itemId);
  decreaseCount( int itemId);
  getCartItemCount( int itemId);
  add(int itemId);
  remove(int itemId);
  checkCoupon();
  getTotalPrice();
  updateItemCountLocally(int itemId, bool isIncrement);
  goToCheckout();
}

class CartControllerImp extends CartController {
  CartData cartData = CartData(Get.find());
 @override
  void onInit() async {
    await initialData();
    getCart();
    super.onInit();
  }
  @override
  initialData() async{
     userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  getCart() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await cartData.getCart();
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          cart.clear();
          cartItems.clear();
          cart.add(response['data']);
          totalPrice = (response['data']['total_price'] as num).toDouble();
          cartItems.addAll(response['data']['items']);
           shippingCost =
          (response['data']['shipping_cost'] as num).toDouble();
          // cartItemsCount = cartItems.length;
          cartItemsCount = response['data']['total_count'];
        } else {
          Get.defaultDialog(title: 'Warning', middleText: "Invalid cart data");
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

  @override
  clearCart() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await cartData.clearCart();
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          cart.add(response['data']);
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

  @override
  addCart( int itemId) async {
    update();
    var response = await cartData.addCart(itemId);
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

  @override
  deleteCart( int itemId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.removeCart( itemId);
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

  @override
  decreaseCount( int itemId) async {
    update();
    var response = await cartData.decreaseCount( itemId);
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

  @override
  getCartItemCount( int itemId) async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await cartData.getCartItemCount( itemId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          itemCount = response['itemCount'];
          return itemCount;
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

  @override
  checkCoupon() async {
    var response = await cartData.checkCoupon(couponController.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        final data = response['data'];

        couponName = data['name'];
        couponId = data['id'];
        couponDiscount = data['discount'];
      } else {
        couponName = null;
        couponDiscount = 0;
        couponId = null;
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

  double getDiscountValue() {
    if (couponDiscount == 0) return 0;
    return totalPrice * (couponDiscount / 100);
  }

  @override
  getTotalPrice() {
    double total = totalPrice.toDouble();
    if (couponDiscount > 0) {
      total = total - (total * (couponDiscount / 100));
    }
    return total;
  }

  @override
  add(int itemId) {
    updateItemCountLocally(itemId, true);
    addCart( itemId);
  }

  @override
  remove(int itemId) async {
    updateItemCountLocally(itemId, false);
    await getCartItemCount(itemId);
    if (itemCount > 0) {
      await decreaseCount( itemId);
      itemCount--;
      update();
    }
  }

  resetCartVars() {
    print("=====================reset");
    itemCount = 0;
    cartItemsCount = 0;
    cartItems.clear();
  }

  refreshCart() {
    print("=====================refresh");
    resetCartVars();
    getCart();
  }

  @override
  updateItemCountLocally(int itemId, bool isIncrement) {
    for (var item in cartItems) {
      if (item['item_id'] == itemId) {
        if (isIncrement) {
          item['count']++;
        } else {
          if (item['count'] > 1) {
            item['count']--;
          }
        }
        break;
      }
    }

    update(["item_$itemId"]);
  }

  @override
  goToCheckout() {
    if (cartItems.isEmpty) {
      return Get.snackbar("Alarm", "the cart is empty");
    }
    Get.toNamed(
      "checkout",
      arguments: {
        "couponId": couponId ,
        "totalPrice": getTotalPrice(),
        "totalPriceWithShipping": getTotalPrice() + cart[0]['shipping_cost'],
      },
    );
  }
}
