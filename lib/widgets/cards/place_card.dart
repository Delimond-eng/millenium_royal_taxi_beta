import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../svg_widget.dart';

class PlaceCard extends StatelessWidget {
  final String? place;
  final String? reference;
  const PlaceCard({super.key, this.place, this.reference});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.zero,
        color: whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Svg(
                path: "pin-4.svg",
                color: primaryColor,
                size: 40.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ).paddingBottom(5.0),
                    Text(
                      reference!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
