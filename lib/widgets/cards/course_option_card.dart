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
    // Example breakpoint for large screens

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(defaultBorderRadius + 3),
            border: Border.all(color: primaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              fit: BoxFit.scaleDown,
              height: 70.0,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Course',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: textColor ?? Colors.grey[100],
                        ),
                  ).paddingRight(5.0),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: textColor ?? Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ],
        ).paddingAll(8.0),
      ),
    );
  }
}
