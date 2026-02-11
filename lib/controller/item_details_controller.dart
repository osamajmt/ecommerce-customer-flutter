import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/cartdata.dart';
import 'package:ecommerce_app/data/model/favoritesmodel.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {
  Services myServices = Get.find();
  List cart = [];
  List cartItems = [];
  int? userId;
  int cartItemsCount = 0;
  var arg;
  late ItemsModel itemsModel;
  late FavoritesModel favoritesModel;
  int itemCount = 0;
  StatusRequest statusRequest = StatusRequest.none;
  initialData();
  addCart( int itemId);
  decreaseCount( int itemId);
  getCartItemCount( int itemId);
  add();
  remove();
}

class ProductDetailsControllerImp extends ProductDetailsController {
  CartData cartData = CartData(Get.find());
  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    update();
    await getUserId();
    arg = Get.arguments['itemsModel'];
    if (arg is FavoritesModel) {
    itemsModel = ItemsModel(
    id: arg.itemId,
    categoryId: arg.categoryId,
    name: arg.name,
    nameAr: arg.nameAr,
    desc: arg.desc,
    descAr: arg.descAr,
    price: arg.price,
    count: arg.count,
    discount: arg.discount ?? 0,
    isActive: arg.isActive == true ? 1 : 0,
    image: arg.image,
    isFavorite: 1,
    );
  } else if (arg is ItemsModel) {
    itemsModel = arg;
  }
    itemCount = await getCartItemCount(itemsModel.id!);
    statusRequest = StatusRequest.success;
    update();
  }
  
  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }


  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  @override
  addCart( int itemId) async {
    var response = await cartData.addCart( itemId);
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
  }

  @override
  decreaseCount( int itemId) async {
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
  }

  @override
  getCartItemCount( int itemId) async {
    try {
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
  add() {
    itemCount++;
    update(["cart_update"]);
    addCart(itemsModel.id!);
  }

  @override
  remove() {
    if (itemCount > 0) {
      decreaseCount( itemsModel.id!);
      itemCount--;
      update(["cart_update"]);
    }
  }
}
