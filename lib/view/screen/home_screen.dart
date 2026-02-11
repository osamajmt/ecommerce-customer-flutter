
import 'package:ecommerce_app/controller/homescreen_controller.dart';
import 'package:ecommerce_app/core/class/handlingdataview.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:ecommerce_app/view/widget/customappbar.dart';
import 'package:ecommerce_app/view/widget/home/categorieslist.dart';
import 'package:ecommerce_app/view/widget/home/customhomecard.dart';
import 'package:ecommerce_app/view/widget/home/customhometitle.dart';
import 'package:ecommerce_app/view/widget/home/ItemsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());

    return GetBuilder<HomeScreenControllerImp>(
      builder:
          (controller) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    onPressedSearchIcon: controller.onItemsSearch,
                  ),

                  const SizedBox(height: 15),

                  Handlingdataview(
                    statusRequest: controller.statusRequest,
                    widget:
                        controller.isSearch == false
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.settings.isNotEmpty)
                                  CustomHomeCard(
                                    title: controller.settings[0]['home_title'],
                                    body: controller.settings[0]['home_body'],
                                  ),

                                const SizedBox(height: 15),

                                CustomHomeTitle(title: "3".tr),
                                const SizedBox(height: 10),
                                const CategoriesList(),

                                const SizedBox(height: 25),

                                CustomHomeTitle(title: "4".tr),
                                const SizedBox(height: 10),
                                const ItemsList(),
                              ],
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

class ItemsSearchList extends GetView<HomeScreenControllerImp> {
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "${AppLink.itemsImages}/${item.image}",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(
                            item.name ?? "",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
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
            );
          },
        );
  }
}
