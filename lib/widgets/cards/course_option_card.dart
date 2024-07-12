import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title, icon;
  final VoidCallback? onSelected;
  final List<Color>? colors;
  final Color? textColor;
  const CourseCard({
    super.key,
    required this.title,
    required this.icon,
    this.onSelected,
    this.colors,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.08,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [primaryColor, Colors.indigo],
        ),
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          width: 1,
          color: colors != null ? greyColor80 : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            fit: BoxFit.scaleDown,
            height: screenSize.height * 0.060,
          ),
          SizedBox(
            width: screenSize.width * 0.020,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Course',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: textColor ?? greyColor10,
                      ),
                ).paddingBottom(2.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: textColor ?? whiteColor),
                )
              ],
            ),
          )
        ],
      ).paddingAll(8.0),
    );
  }
}
