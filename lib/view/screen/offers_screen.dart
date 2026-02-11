import 'package:ecommerce_app/controller/favorites_controller.dart';
import 'package:ecommerce_app/controller/items_controller.dart';
import 'package:ecommerce_app/controller/offers_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:ecommerce_app/view/widget/customappbar.dart';
import 'package:ecommerce_app/view/widget/offers/customoffersitemsgrid.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesControllerImp());
    Get.put(OffersControllerImp());

    return GetBuilder<OffersControllerImp>(
      builder:
          (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget:
               controller.statusRequest == StatusRequest.success && controller.offers.isEmpty
                    ? Center(
                      child: Text(
                        "154".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                    :controller.statusRequest == StatusRequest.loading?
                    Lottie.asset(
                      'assets/lotties/loading_spinner.json',
                      width: 150,
                      height: 150,
                      repeat: true
                    )
                    : controller.isSearch == false
                    ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                           CustomAppBar(
                            myController: controller.searchController,
                            title: "149".tr,
                            onPressedFavIcon: controller.goToFav,
                            onChanged: controller.checkSearch(),
                            onPressedNotIcon: () {},
                            onClearSearch: controller.clearSearch,
                            isSearch: controller.isSearch ?? false,
                            onPressedSearchIcon: controller.onItemsOffersSearch,
                          ),
                          const SizedBox(height: 10),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 0.675,
                                ),
                            itemCount: controller.offers.length,
                            itemBuilder: (context, index) {
                              final item = ItemsModel.fromJson(
                                controller.offers[index],
                              );
                              return CustomOffersItemsGrid(
                                itemsModel: item,
                                isActive: item.isFavorite ?? 0,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                    : Column(
                      children: [
                         CustomAppBar(
                            myController: controller.searchController,
                            title: "149".tr,
                            onPressedFavIcon: controller.goToFav,
                            onChanged: controller.checkSearch(),
                            onPressedNotIcon: () {},
                            onClearSearch: controller.clearSearch,
                            isSearch: controller.isSearch ?? false,
                            onPressedSearchIcon: controller.onItemsOffersSearch,
                          ),
                        ItemsSearchList(itemsList: controller.itemsSearchList),
                      ],
                    ),
          ),
    );
  }
}

class ItemsSearchList extends GetView<ItemsControllerImp> {
  final List<ItemsModel> itemsList;
  const ItemsSearchList({super.key, required this.itemsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            controller.goToProductPage(itemsList[index]);
          },
          child: Container(
            margin: EdgeInsets.all(5),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        AppLink.itemsImages + "/${itemsList[index].image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text("${itemsList[index].name}"),
                        subtitle: Text(
                          "Amount available: ${itemsList[index].count}",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

