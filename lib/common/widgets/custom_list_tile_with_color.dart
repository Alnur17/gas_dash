import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomListTileWithColor extends StatelessWidget {
  final String? leadingIconPath;
  final String title;
  final String? trailingIconPath;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomListTileWithColor({
    super.key,
    this.leadingIconPath,
    required this.title,
    this.trailingIconPath,
    required this.onTap,
    this.backgroundColor = AppColors.silver,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (leadingIconPath != null)
                Image.asset(
                  leadingIconPath!,
                  scale: 4,
                ),
              if (leadingIconPath != null) const SizedBox(width: 16),
              Text(
                title,
                style: h4.copyWith(color: textColor ?? Colors.black),
              ),
              const Spacer(),
              if (trailingIconPath != null)
                Image.asset(
                  trailingIconPath!,
                  scale: 4,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
