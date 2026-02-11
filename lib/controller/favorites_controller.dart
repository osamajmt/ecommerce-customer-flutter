import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/homedata.dart';
import 'package:ecommerce_app/data/dataSource/remote/itemsdata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/data/model/favoritesmodel.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class FavoritesController extends GetxController {
  Services myServices = Get.find();
  List favItems = [];
  int? userId;
  StatusRequest? statusRequest;
  TextEditingController searchController = TextEditingController();
  bool? isSearch = false;
  List<ItemsModel> itemsSearchList = [];
  initialData();
  getFavItems(int userId);
  goToFavProductPage(FavoritesModel favoritesModel);
  goToFav();
  toggleFavorite(FavoritesModel item);
  checkSearch();
  onItemsSearch();
  getSearchItems();
  goToProductPage(ItemsModel itemsModel);
}

class FavoritesControllerImp extends FavoritesController {
  HomeData homeData = HomeData(Get.find());
  ItemsData itemsData = ItemsData(Get.find());
  @override
  initialData() async{
     userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
  }

  @override
  goToFavProductPage(FavoritesModel favoritesModel) {
    Get.toNamed('productDetails', arguments: {"itemsModel": favoritesModel});
  }

  @override
  getFavItems(int userId) async {
    try {
      favItems.clear();
      statusRequest = StatusRequest.loading;
      var response = await itemsData.getFavItems(userId);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
         
        favItems.addAll(response['items']);
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
  goToFav() {
    Get.toNamed(appRoute.favItems);
  }

  @override
  toggleFavorite(FavoritesModel item) async {
    int? userId = myServices.sharedPreferences.getInt("id");
    if (userId == null) return;

    favItems.removeWhere((e) => e['id'] == item.id);
    update();

    var response = await itemsData.toggleFavorite(item.id!, userId);

    if (response['status'] != 'success' && response['status'] != 'deleted') {
      getFavItems(userId);
    }
  }

  @override
  void onInit() async{
    await initialData();
    getFavItems(userId!);
    super.onInit();
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
  void clearSearch() {
  searchController.clear();
  itemsSearchList.clear();
  isSearch = false;
  statusRequest = StatusRequest.none;
  update();
}

  @override
  goToProductPage(ItemsModel itemsModel) {
    Get.toNamed('productDetails', arguments: {"itemsModel": itemsModel});
  }
}
