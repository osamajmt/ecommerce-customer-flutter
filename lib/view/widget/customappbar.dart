import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function()? onPressedNotIcon;
  final Function()? onPressedSearchIcon;
  final Function()? onPressedFavIcon;
  final Function()? onClearSearch;
  final Function(String)? onChanged;
  final TextEditingController myController;
  final String title;
  final bool isSearch;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPressedNotIcon,
    this.onPressedSearchIcon,
    this.onPressedFavIcon,
    this.onClearSearch,
    this.onChanged,
    required this.myController,
    required this.isSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: myController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: title,
                prefixIcon: IconButton(
                  icon: Icon(
                    isSearch ? Icons.close : Icons.search,
                  ),
                  onPressed: isSearch
                      ? onClearSearch
                      : onPressedSearchIcon,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: onPressedFavIcon,
            ),
          ),
        ],
      ),
    );
  }
}

