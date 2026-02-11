
import 'package:ecommerce_app/controller/items_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/categoriesmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<ItemsControllerImp>(
      builder: (controller) {
        if (controller.categories.isEmpty) {
          return const SizedBox(height: 45);
        }

        return SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category =
                  CategoriesModel.fromJson(controller.categories[index]);
              final isSelected = controller.selectedCat == category.id!;

              return GestureDetector(
                onTap: () => controller.changeCat(category.id!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    translate(category.nameAr, category.name),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.textTheme.bodyMedium?.color,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

