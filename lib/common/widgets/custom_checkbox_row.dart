import 'package:flutter/material.dart';

class CustomCheckboxRow extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final TextStyle? textStyle;

  const CustomCheckboxRow({
    super.key,
    required this.value,
    required this.text,
    required this.onChanged,
    this.activeColor = Colors.black,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
