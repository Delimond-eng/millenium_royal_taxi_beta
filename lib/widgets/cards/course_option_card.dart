import 'package:flutter/material.dart';
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
          gradient: LinearGradient(
            colors: colors ?? [Theme.of(context).primaryColor, Colors.indigo],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              fit: BoxFit.scaleDown,
              height: 60.0,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Course',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: textColor ?? Colors.grey[100],
                        ),
                  ),
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
