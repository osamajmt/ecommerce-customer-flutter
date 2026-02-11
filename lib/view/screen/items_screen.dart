import 'package:ecommerce_app/controller/items_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:ecommerce_app/view/widget/customappbar.dart';
import 'package:ecommerce_app/view/widget/items/categoriesList.dart';
import 'package:ecommerce_app/view/widget/items/customitemsgrid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsControllerImp());

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ItemsControllerImp>(
          builder:
              (controller) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                    const SizedBox(height: 20),

                    if (controller.isSearch)
                      Text(
                        "3".tr,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                    if (controller.isSearch == false)
                      const SizedBox(height: 10),
                    if (controller.isSearch == false) const CategoriesList(),

                    const SizedBox(height: 15),

                    Expanded(
                      child: Handlingdataview(
                        statusRequest: controller.statusRequest,
                        widget:
                            controller.isSearch
                                ? ItemsSearchList(
                                  itemsList: controller.itemsSearchList,
                                )
                                :controller.statusRequest == StatusRequest.loading?
                               Center(
                                child: Lottie.asset('assets/lotties/loading_spinner.json'),
                                )
                                : controller.items.isEmpty
                                ? Center(
                                    child: Text(
                                      "No items in this category",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  )
                                
                                : GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: controller.items.length,
                                  itemBuilder: (context, index) {
                                    final item = ItemsModel.fromJson(
                                      controller.items[index],
                                    );

                                    return CustomItemsGrid(
                                      itemsModel: item,
                                      isActive: item.isFavorite ?? 0,
                                    );
                                  },
                                ),
                      ),
                    ),
                  ],
                ),
              ),
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
    return itemsList.isEmpty
        ? Center(
          child: Text("150".tr, style: Theme.of(context).textTheme.bodyMedium),
        )
        : ListView.builder(
          itemCount: itemsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = itemsList[index];

            return InkWell(
              onTap: () => controller.goToProductPage(item),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
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
                            title: Text(
                              item.name ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "${"151".tr} ${item.count}",
                              style: Theme.of(context).textTheme.bodySmall,
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


