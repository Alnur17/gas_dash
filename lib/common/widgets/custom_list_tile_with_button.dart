import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../size_box/custom_sizebox.dart';

class CustomListTileWithButton extends StatelessWidget {
  final String name;
  final String actionText;
  final VoidCallback actionOnPressed;
  final bool showCloseButton;
  final VoidCallback? closeOnPressed;
  final Widget actionStyle;
  final String? image;

  const CustomListTileWithButton({
    super.key,
    required this.name,
    required this.actionText,
    required this.actionOnPressed,
    this.showCloseButton = false,
    this.closeOnPressed,
    required this.actionStyle,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: image != null
          ? CircleAvatar(
        backgroundImage: NetworkImage(image!),
        backgroundColor: Colors.transparent,
      )
          : CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(name[0].toUpperCase()),
      ),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          actionStyle,
          if (showCloseButton) ...[
            sw12,
            GestureDetector(
              onTap: closeOnPressed,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Image.asset(
                  AppImages.close,
                  scale: 4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
