import 'package:flutter/material.dart';

import '../app_images/app_images.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;

  const CustomBackground({
    super.key,
    required this.child,
    this.backgroundImage = AppImages.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage ?? AppImages.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
