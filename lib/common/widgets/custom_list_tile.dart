import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomListTile extends StatelessWidget {
  final String leadingImage;
  final String title;
  final TextStyle? titleStyle;
  final String? rightText;
  final String? trailingImage;
  final bool? isSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.leadingImage,
    required this.title,
    this.rightText,
    this.trailingImage,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.onTap,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.silver)
      ),
      child: ListTile(
        leading: Image.asset(
          leadingImage,
          scale: 4,
        ),
        title: Row(
          children: [
            Text(
              title,
              style: titleStyle ?? h5.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (rightText != null) Text(rightText!, style: h3),
          ],
        ),
        trailing: isSwitch == true
            ? Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: AppColors.blue,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                ),
              )
            : trailingImage != null
                ? Image.asset(
                    trailingImage!,
                    //color: AppColors.black,
                    scale: 4,
                  )
                : null,
        onTap: onTap,
      ),
    );
  }
}
