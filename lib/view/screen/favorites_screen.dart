import 'package:ecommerce_app/controller/favorites_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/data/model/favoritesmodel.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:ecommerce_app/view/widget/customappbar.dart';
import 'package:ecommerce_app/view/widget/items/customfavitemsgrid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesControllerImp());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GetBuilder<FavoritesControllerImp>(
          builder: (controller) => ListView(
            children: [
               CustomAppBar(
                    myController: controller.searchController,
                    title: "149".tr,
                    onPressedFavIcon: controller.goToFav,
                    onChanged: controller.checkSearch(),
                    onPressedNotIcon: () {},
                    onClearSearch: controller.clearSearch,
                     isSearch: controller.isSearch ?? false,
                    onPressedSearchIcon: controller.onItemsSearch,
                  ),
              const SizedBox(height: 15),
              Handlingdataview(
                statusRequest: controller.statusRequest,
                widget: controller.isSearch == false
                    ? controller.favItems.isEmpty
                        ? Center(
                            child: Text(
                              "155".tr,
                              style:
                                  Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.675,
                            ),
                            itemCount: controller.favItems.length,
                            itemBuilder: (context, index) {
                              return CustomFavItemsGrid(
                                isActive: 1,
                                favoritesModel:
                                    FavoritesModel.fromJson(
                                  controller.favItems[index],
                                ),
                              );
                            },
                          )
                    : ItemsSearchList(
                        itemsList: controller.itemsSearchList,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsSearchList extends GetView<FavoritesControllerImp> {
  final List<ItemsModel> itemsList;
  const ItemsSearchList({super.key, required this.itemsList});

  @override
  Widget build(BuildContext context) {
    return itemsList.isEmpty
        ? Center(child: Text("150".tr))
        : ListView.builder(
            itemCount: itemsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = itemsList[index];
              return InkWell(
                onTap: () => controller.goToProductPage(item),
                child: Card(
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            "${AppLink.itemsImages}/${item.image}",
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            title: Text(item.name ?? ""),
                            subtitle: Text(
                              "${"151".tr} ${item.count}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}



