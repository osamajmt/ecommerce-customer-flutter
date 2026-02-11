import 'package:ecommerce_app/controller/items_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemsGrid extends GetView<ItemsControllerImp> {
  final ItemsModel itemsModel;
  final int isActive;

  const CustomItemsGrid({
    super.key,
    required this.itemsModel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => controller.goToProductPage(itemsModel),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: '${itemsModel.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                            size: 150,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                translate(itemsModel.nameAr, itemsModel.name),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemsModel.discountPrice == null
                        ? "\$${itemsModel.price}"
                        : "\$${itemsModel.discountPrice}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GetBuilder<ItemsControllerImp>(
                    id: "fav_${itemsModel.id}",
                    builder:
                        (controller) => IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed:
                              () => controller.toggleFavorite(itemsModel),
                          icon: Icon(
                            itemsModel.isFavorite == 1
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline,
                            color:
                                itemsModel.isFavorite == 1
                                    ? Colors.redAccent
                                    : Colors.grey,
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
