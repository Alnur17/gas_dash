import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../app_color/app_colors.dart';

class UploadWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? imagePath;
  final File? fileImage;
  final String label;
  final double height;
  final double width;
  final double iconSize;
  final TextStyle? labelStyle;

  const UploadWidget({
    super.key,
    required this.onTap,
    this.imagePath,
    this.fileImage,
    required this.label,
    this.height = 160,
    this.width = double.infinity,
    this.iconSize = 50,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Use minimum space needed
            children: [
              if (fileImage != null)
                Image.file(
                  fileImage!,
                  height: height -4 ,
                  width: width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: $error');
                    return Icon(Icons.error, color: Colors.red);
                  },
                )
              else ...[
                SizedBox(height: 4), // Further reduced from 6
                Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading asset: $error');
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ),
                SizedBox(height: 4), // Further reduced from 8
                Text(
                  label,
                  style: labelStyle ?? h5.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}