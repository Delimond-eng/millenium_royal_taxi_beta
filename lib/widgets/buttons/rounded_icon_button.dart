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
        elevation: 2.0,
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40.0),
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Svg(
                  path: icon,
                  color: blackColor80,
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
