import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/homedata.dart';
import 'package:ecommerce_app/data/dataSource/remote/itemsdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class OffersController extends GetxController {
  Services myServices = Get.find();
  StatusRequest? statusRequest = StatusRequest.none;
  List offers = [];
  List categories = [];
  int? selectedCat;
  int? userId;
  TextEditingController searchController = TextEditingController();
  bool? isSearch = false;
  List<ItemsModel> itemsSearchList = [];
  initialData();
  toggleFavorite(ItemsModel item);
  getOffers(int userId);
  goToProductPage(ItemsModel itemsModel);
  goToFav();
  checkSearch();
  onItemsOffersSearch();
  getSearchOffers();
}

class OffersControllerImp extends OffersController {
  ItemsData itemsData = ItemsData(Get.find());
  HomeData homeData = HomeData(Get.find());
  @override
  initialData()async {
    await getUserId();
    getOffers(userId!);
  }

  getUserId() async {
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  getOffers(int userId) async {
    offers.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await itemsData.getDiscountItems(userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          offers.addAll(response['items']);
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

  @override
  goToProductPage(ItemsModel itemsModel) {
    Get.toNamed('productDetails', arguments: {"itemsModel": itemsModel});
  }

  @override
  toggleFavorite(ItemsModel item) async {
    if (userId == null) {
      print("User ID is null");
      return;
    }
    var response = await itemsData.toggleFavorite(item.id!, userId!);

    if (response['status'] == 'added') {
      item.isFavorite = 1;
    } else {
      item.isFavorite = 0;
    }
    update(["fav_${item.id}"]);
  }

  @override
  goToFav() {
    Get.toNamed(appRoute.favItems);
  }

 
  @override
  checkSearch() {
  if (searchController.text.isEmpty) {
    clearSearch();
  }
}

  @override
  onItemsOffersSearch() {
    isSearch = true;
    getSearchOffers();
    update();
  }

void clearSearch() {
  searchController.clear();
  itemsSearchList.clear();
  isSearch = false;
  statusRequest = StatusRequest.none;
  update();
}
  @override
  getSearchOffers() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await itemsData.searchOffers(searchController.text);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          itemsSearchList.clear();
          List itemsList = response['items'];
          //  itemsSearchList.addAll(itemsList);
          itemsSearchList.addAll(itemsList.map((e) => ItemsModel.fromJson(e)));
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
   @override
  void onInit() {
    initialData();
    super.onInit();
  }

}
