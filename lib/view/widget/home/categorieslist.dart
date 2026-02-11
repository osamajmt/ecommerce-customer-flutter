import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/homescreen_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/categoriesmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        if (controller.categories.isEmpty) {
          return const SizedBox(
            height: 110,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = CategoriesModel.fromJson(controller.categories[index]);
              return Categories(
                selectedCat: category.id!,
                categoriesModel: category
              );
            },
          ),
        );
      },
    );
  }
}

class Categories extends GetView<HomeScreenControllerImp> {
  final CategoriesModel categoriesModel;
  final int selectedCat;

  const Categories({
    super.key,
    required this.selectedCat,
    required this.categoriesModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => controller.goToItems(controller.categories, selectedCat),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: SvgPicture.network(
              "${AppLink.categoriesImages}/${categoriesModel.image}",
              color: AppColor.primaryColor,
              placeholderBuilder:
                  (context) => const Icon(Icons.image, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            translate(categoriesModel.nameAr, categoriesModel.name),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
