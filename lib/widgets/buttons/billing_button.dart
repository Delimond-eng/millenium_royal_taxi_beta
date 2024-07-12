import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import '../svg_widget.dart';
import '/theme/app_theme.dart';

class BillingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BillingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        color: whiteColor,
        border: Border.all(color: greyColor60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Mode de paiement",
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/mbile-money.png",
                    height: 30.0,
                    fit: BoxFit.scaleDown,
                  ).paddingRight(2),
                  Image.asset(
                    "assets/icons/mastercard.png",
                    height: 30.0,
                    fit: BoxFit.scaleDown,
                  ).paddingRight(2),
                  Image.asset(
                    "assets/icons/visa.png",
                    height: 30.0,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ).paddingRight(5.0),
              Svg(
                path: "right-arrow-4.svg",
                color: Colors.grey.shade600,
                size: 22.0,
              )
            ],
          )
        ],
      ).paddingHorizontal(10.0),
    );
  }
}
