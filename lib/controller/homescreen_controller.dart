import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/homedata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  Services myServices = Get.find();
  String? userName;
  int? userId;
  StatusRequest? statusRequest;
  List categories = [];
  List items = [];
  List settings = [];
  List topSellingItems = [];
  String? lang;
  TextEditingController searchController = TextEditingController();
  bool? isSearch;
  List<ItemsModel> itemsSearchList = [];
  getCategories();
  initialData();
  getItems();
  getSettings();
  goToFav();
  goToItems(List categories, int selectedCat);
  checkSearch();
  onItemsSearch();
  getSearchItems();
  getTopSellingItems($userId);
  goToProductPage(ItemsModel itemsModel);
}

class HomeScreenControllerImp extends HomeScreenController {
  HomeData homeData = HomeData(Get.find());
  @override
  initialData() async {
    lang = myServices.sharedPreferences.getString("lang");
    print(lang);
    userName = myServices.sharedPreferences.getString('user_name');
    print(userName);
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  void onInit() async {
    await initialData();
    getSettings();
    getItems();
    getCategories();
    getTopSellingItems(userId);
    super.onInit();
  }

  @override
  goToItems(List categories, int selectedCat) {
    Get.toNamed(
      appRoute.items,
      arguments: {"categories": categories, "selectedCat": selectedCat},
    );
  }

  @override
  goToFav() {
    Get.toNamed(appRoute.favItems);
  }

  @override
  getCategories() async {
    categories.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getCategories();
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          categories.addAll(response['categories']);
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
  getItems() async {
    items.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getItems();
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          items.addAll(response['items']);
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
  getSettings() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getSettings();
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          settings.addAll(response['settings']);
          myServices.sharedPreferences.setString(
            "deliveryTime",
            settings[0]['delivery_time'] ?? "",
          );
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
  getTopSellingItems($userId) async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getTopSellingItems($userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          topSellingItems.addAll(response['items']);
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
  checkSearch() {
    if (searchController.text.isEmpty) {
      clearSearch();
    }
  }

  @override
  onItemsSearch() {
    isSearch = true;
    getSearchItems();
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
  getSearchItems() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.searchItems(searchController.text);
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
  goToProductPage(ItemsModel itemsModel) {
    Get.toNamed('productDetails', arguments: {"itemsModel": itemsModel});
  }
}
