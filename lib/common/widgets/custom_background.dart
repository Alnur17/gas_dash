import 'package:flutter/material.dart';

import '../app_images/app_images.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final String? backgroundImages;

  const CustomBackground({
    super.key,
    required this.child,
    this.backgroundImages = AppImages.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImages ?? AppImages.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
