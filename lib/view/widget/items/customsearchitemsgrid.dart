
import 'package:ecommerce_app/controller/items_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchItemsGrid extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;

  const CustomSearchItemsGrid({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  GetBuilder<ItemsControllerImp>(
      builder: (controller) {
        if (controller.categories.isEmpty) {
          return const SizedBox(height: 45);
        }
       return InkWell(
      onTap: () {
        controller.goToProductPage(itemsModel);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: '${itemsModel.id}',
                child: Image.network(
                    "${AppLink.itemsImages}/${itemsModel.image}",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
              ),
              Text(
                translate(itemsModel.nameAr, itemsModel.name),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${itemsModel.price}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
        });
  }
}
