import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';
import '/models/ride_option.dart';

class RideOptionCard extends StatelessWidget {
  final RideOption item;
  final bool isActive;
  const RideOptionCard({super.key, required this.item, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: screenSize.height * 0.16,
          width: screenSize.width * 0.35,
          margin: EdgeInsets.only(
            right: screenSize.width * 0.02,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isActive
                  ? [
                      primaryColor,
                      const Color.fromARGB(255, 60, 8, 8),
                    ]
                  : [whiteColor, whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
                color: isActive ? Colors.transparent : greyColor40, width: 3.0),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: isActive ? whiteColor : primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                ).paddingBottom(screenSize.height * 0.006),
                Text(
                  '${item.price} CDF',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isActive ? greyColor60 : blackColor80,
                        fontSize: screenSize.height *
                            0.015, // Taille de la police basée sur la hauteur de l'écran
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.timer_sharp,
                      size: screenSize.height * 0.015,
                      color: isActive
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                    ).paddingRight(screenSize.width * 0.01),
                    Text(
                      '${item.timeOfArrival.minute.toString()} min',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: isActive ? greyColor60 : blackColor80,
                            fontSize: screenSize.height *
                                0.01, // Taille de la police basée sur la hauteur de l'écran
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -screenSize.height *
              0.04, // Positionnement en haut basé sur la hauteur de l'écran
          right: -screenSize.width *
              0.03, // Positionnement à droite basé sur la largeur de l'écran
          child: Image.asset(
            item.icon,
            fit: BoxFit.scaleDown,
            height: screenSize.height *
                0.15, // Hauteur de l'image basée sur la hauteur de l'écran
          ),
        ),
      ],
    );
  }
}
