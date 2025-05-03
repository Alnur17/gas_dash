import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuItemData> items;

  const CustomPopupMenuButton({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.black,
      icon: Image.asset(
        AppImages.menu,
        scale: 4,
      ),
      onSelected: (value) {
        final selectedItem = items.firstWhere(
              (item) => item.value == value && !item.isDivider,
        );
        selectedItem.onSelected!();
      },
      itemBuilder: (context) => items
          .map((item) {
        if (item.isDivider) {
          return const PopupMenuDivider(); // Add the divider
        }
        return PopupMenuItem<String>(
          height: 25,
          value: item.value,
          child: Text(
            item.label,
            style: h5.copyWith(color: AppColors.white),
          ),
        );
      })
          .toList()
          .cast<PopupMenuEntry<String>>(),
    );
  }
}

class PopupMenuItemData {
  final String value;
  final String label;
  final VoidCallback? onSelected;
  final bool isDivider;

  PopupMenuItemData({
    this.value = '',
    this.label = '',
    this.onSelected,
    this.isDivider = false,
  });
}
