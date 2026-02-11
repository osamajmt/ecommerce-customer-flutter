
import 'package:ecommerce_app/controller/favorites_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/favoritesmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFavItemsGrid extends GetView<FavoritesControllerImp> {
  final FavoritesModel favoritesModel;
  final int isActive;

  const CustomFavItemsGrid({
    super.key,
    required this.favoritesModel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        controller.goToFavProductPage(favoritesModel);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: '${favoritesModel.id}',
                child:  Image.network(
                    "${AppLink.itemsImages}/${favoritesModel.image}",
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
                translate(favoritesModel.nameAr, favoritesModel.name),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${favoritesModel.price}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.toggleFavorite(favoritesModel);
                    },
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: theme.colorScheme.primary,
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

