import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/homedata.dart';
import 'package:ecommerce_app/data/dataSource/remote/itemsdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/data/model/categoriesmodel.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ItemsController extends GetxController {
  Services myServices = Get.find();
  StatusRequest? statusRequest;
  List items = [];
  List categories = [];
  int? selectedCat;
  String? deliveryTime;
  int? userId;
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  List<ItemsModel> itemsSearchList = [];
  initialData();
  changeCat(int i);
  getAllItems();
  toggleFavorite(ItemsModel item);
  getItems(int catId);
  goToProductPage(ItemsModel itemsModel);
  goToFav();
  checkSearch();
  onItemsSearch();
  getSearchItems();
}

class ItemsControllerImp extends ItemsController {
  ItemsData itemsData = ItemsData(Get.find());
  HomeData homeData = HomeData(Get.find());
  @override
  initialData() async {
    deliveryTime = myServices.sharedPreferences.getString("deliveryTime");
    final args = Get.arguments;
    categories = args?["categories"] ?? [];
    if (args?["selectedCat"] != null) {
      selectedCat = args["selectedCat"];
    } else if (categories.isNotEmpty) {
      selectedCat = CategoriesModel.fromJson(categories.first).id;
    }
    await getUserId();
    getItems(selectedCat!);
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
  changeCat(int i) {
    selectedCat = i;
    statusRequest = StatusRequest.loading;
    update();
    getItems(selectedCat!);
  }

  @override
  getAllItems() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await itemsData.getAllItems();
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
  getItems(int catId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.getItems(catId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          items.clear();
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
  goToProductPage(ItemsModel itemsModel) {
    Get.toNamed('productDetails', arguments: {"itemsModel": itemsModel});
  }

  @override
  toggleFavorite(ItemsModel item) async {
    print("item id:${item.id!}");
    print("${myServices.sharedPreferences.getInt("id")}");
    // int? userId = myServices.sharedPreferences.getInt("id");
    int? userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
    if (userId == null) {
      print("User ID is null");
      return;
    }
    var response = await itemsData.toggleFavorite(item.id!, userId);

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
}
