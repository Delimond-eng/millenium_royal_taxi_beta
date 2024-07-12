import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

class BorderedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final String? label;
  final Color? color;
  final VoidCallback? onPressed;
  const BorderedButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.onPressed,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 35.0,
      width: width ?? 80.0,
      decoration: BoxDecoration(
        border: Border.all(color: color ?? primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(radius ?? 30),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 30),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label ?? 'Modifier',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: color ?? primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
