import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:ecommerce_app/controller/offers_controller.dart';
import 'package:ecommerce_app/core/function/translate.dart';
import 'package:ecommerce_app/data/model/itemsmodel.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOffersItemsGrid extends GetView<OffersControllerImp> {
  final ItemsModel itemsModel;
  final int isActive;
  const CustomOffersItemsGrid({
    super.key,
    required this.itemsModel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => controller.goToProductPage(itemsModel),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.08),
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
                    child: Stack(
                      children: [
                        Image.network(
                          "${AppLink.itemsImages}/${itemsModel.image}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 600,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 400,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                        if ((itemsModel.discount ?? 0) > 0)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "-${itemsModel.discount}%",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                translate(itemsModel.nameAr, itemsModel.name),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "\$${itemsModel.discountPrice ?? itemsModel.price}",
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (itemsModel.discountPrice != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            "\$${itemsModel.price}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),
                  GetBuilder<OffersControllerImp>(
                    id: "fav_${itemsModel.id}",
                    builder:
                        (controller) => IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed:
                              () => controller.toggleFavorite(itemsModel),
                          icon: Icon(
                            (itemsModel.isFavorite ?? 0) == 1
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline,
                            color:
                                (itemsModel.isFavorite ?? 0) == 1
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
