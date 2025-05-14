import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';

class EarningsCard extends StatelessWidget {
  final String title;
  final String amount;
  final String? dropDown;
  final Color? backgroundColor;
  final List<Color>? gradientColor;

  const EarningsCard({
    super.key,
    required this.title,
    required this.amount,
    this.dropDown,
    this.gradientColor, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: gradientColor == null
            ? backgroundColor ?? AppColors.transparent
            : null,
        gradient: gradientColor != null
            ? LinearGradient(
          colors: gradientColor!,
        )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: h5.copyWith(fontSize: 18, color: AppColors.white),
              ),
              if (dropDown != null)
                DropdownButton<String>(
                  iconEnabledColor: AppColors.white,
                  underline: SizedBox(),
                  dropdownColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  value: dropDown,
                  onChanged: (String? newValue) {},
                  items: <String>['Last Month', 'This Month', 'Today']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: h6.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
          //SizedBox(height: 10),
          Text(
            '\$$amount',
            style: h3.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
