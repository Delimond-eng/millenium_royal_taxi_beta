import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

import '../svg_widget.dart';

class RoundedIconButton extends StatelessWidget {
  final String icon;
  final double? iconSize;
  final VoidCallback? onPressed;
  const RoundedIconButton(
      {super.key, required this.icon, this.onPressed, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        margin: EdgeInsets.zero,
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Svg(
                  path: icon,
                  color: blackColor,
                  size: iconSize ?? 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
