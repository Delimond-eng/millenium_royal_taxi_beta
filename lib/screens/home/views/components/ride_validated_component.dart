import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../../../../widgets/buttons/bordered_button.dart';
import '../../../../widgets/buttons/rounded_icon_button.dart';
import '../../../../widgets/snap_bar.dart';
import '../../../../widgets/svg_widget.dart';
import '../../states/home_state.dart';

class RideValidatedComponent extends StatefulWidget {
  const RideValidatedComponent({super.key});

  @override
  State<RideValidatedComponent> createState() => _RideValidatedComponentState();
}

class _RideValidatedComponentState extends State<RideValidatedComponent> {
  @override
  Widget build(BuildContext context) {
    final state = Get.put(HomeState());
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: 0.32,
          minChildSize: 0.18,
          maxChildSize: 0.32,
          snap: false,
          expand: false,
          builder: (BuildContext context, scrollSheetController) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: Card(
                    elevation: 10.0,
                    shadowColor: blackColor,
                    margin: EdgeInsets.zero,
                    color: darkColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      controller: scrollSheetController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        const SnapBar(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Standard",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                ).paddingBottom(10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '4500 CDF',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: whiteColor),
                                    ).paddingBottom(5.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.timer_sharp,
                                          size: 15.0,
                                          color: whiteColor,
                                        ).paddingRight(4.0),
                                        Text(
                                          '30 min',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: primaryColor,
                                              ),
                                        ),
                                      ],
                                    ).paddingTop(25.0),
                                  ],
                                )
                              ],
                            ),
                            _selectedRideOptionCarCard(context)
                          ],
                        ).paddingHorizontal(15.0),
                        const DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: .6,
                          dashColor: Colors.grey,
                          dashLength: 4,
                        ).paddingVertical(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/profil-2.png",
                                  height: 50,
                                  fit: BoxFit.scaleDown,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gaston Delimond",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ).paddingBottom(4.0),
                                    Row(
                                      children: [
                                        const Svg(
                                          path: "star.svg",
                                          size: 16.0,
                                          color: primaryColor,
                                        ).paddingRight(4.0),
                                        Text(
                                          "4.5",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: whiteColor,
                                              ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 55.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Svg(
                                    path: "call-1.svg",
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ).paddingHorizontal(10).paddingBottom(10),
                        BorderedButton(
                          label: "Annuler la course",
                          height: 56.0,
                          radius: 20.0,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {},
                        ).paddingHorizontal(10.0),
                        const SizedBox(
                          height: 12.0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: 10.0,
                  child: RoundedIconButton(
                    icon: "arrow-left-2.svg",
                    iconSize: 22.0,
                    onPressed: () {
                      state.animateToNextPage(0);
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _selectedRideOptionCarCard(context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: screenSize.height * 0.12,
          width: screenSize.width * 0.35,
          decoration: BoxDecoration(
            color: const Color(0xFF5e3023),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Positioned(
          left: -40.0,
          child: Image.asset(
            "assets/icons/car-1.png",
            fit: BoxFit.scaleDown,
            height: screenSize.height * 0.16,
          ),
        ),
      ],
    );
  }

  double calculateContentHeight(double maxHeight) {
    double contentHeight = 320.0;
    return contentHeight;
  }
}
