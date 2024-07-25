import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../../../../constants/ride_options.dart';
import '../../../../widgets/buttons/billing_button.dart';
import '../../../../widgets/buttons/bordered_button.dart';
import '../../../../widgets/buttons/rounded_icon_button.dart';
import '../../../../widgets/buttons/submit_loader_btn.dart';
import '../../../../widgets/cards/ride_option_card.dart';
import '../../../../widgets/snap_bar.dart';
import '../../../../widgets/svg_widget.dart';
import '../../../../widgets/textfields/rt_checkbox.dart';
import '../../states/home_state.dart';

class RideSelectionComponent extends StatefulWidget {
  const RideSelectionComponent({super.key});

  @override
  State<RideSelectionComponent> createState() => _RideSelectionComponentState();
}

class _RideSelectionComponentState extends State<RideSelectionComponent> {
  late HomeState state;
  bool isAgreement = false;

  @override
  void initState() {
    super.initState();
    state = Get.put(HomeState());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: .57,
          minChildSize: 0.15,
          maxChildSize: .57,
          snap: false,
          expand: false,
          builder: (BuildContext context, scrollSheetController) {
            return Stack(
              clipBehavior: Clip.none,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Svg(
                                  path: "pin-2.svg",
                                  size: 30.0,
                                  color: primaryColor,
                                ),
                                Expanded(
                                  child: Text(
                                    "03, Avenue Bismark Golf",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ).marginOnly(top: 4),
                                ),
                                const BorderedButton()
                              ],
                            ),
                            const DottedLine(
                              direction: Axis.vertical,
                              lineLength: 15.0,
                              lineThickness: 2.0,
                              dashColor: primaryColor,
                              dashLength: 6,
                            ).paddingLeft(13.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Svg(
                                  path: "pin-4.svg",
                                  size: 30.0,
                                  color: whiteColor,
                                ),
                                Expanded(
                                  child: Text(
                                    "Gare Central, Beach Ngombila",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const BorderedButton()
                              ],
                            ),
                          ],
                        ).paddingHorizontal(10.0),
                        const DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: .3,
                          dashLength: 4,
                        ).paddingVertical(10.0),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(10.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: rideOptions
                                .map(
                                  (el) => RideOptionCard(
                                    item: el,
                                    isActive: rideOptions.indexOf(el) == 0
                                        ? true
                                        : false,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: .3,
                          dashLength: 4,
                        ).paddingVertical(10.0),
                        BillingButton(
                          onPressed: () {},
                        ).paddingHorizontal(10.0).paddingBottom(10.0),
                        Row(
                          children: [
                            Flexible(
                              child: RTCheckbox(
                                color: blackColor60,
                                isChecked: isAgreement,
                                onChecked: () {
                                  setState(() {
                                    isAgreement = !isAgreement;
                                  });
                                },
                                title:
                                    "Je m'engage à payer ma course, même si le prix augmente à cause des embouteillages ou des arrêts demandés !",
                              ),
                            ),
                          ],
                        ).paddingHorizontal(10).paddingBottom(15.0),
                        SizedBox(
                          height: 56.0,
                          child: SubmitLoaderButton(
                            disabled: !isAgreement,
                            child: Text(
                              "Commander un taxi maintenant",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: whiteColor,
                                  ),
                            ),
                            onPressed: () {
                              state.animateToNextPage(5);
                            },
                          ).paddingHorizontal(10.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
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

  double calculateContentHeight(double maxHeight) {
    double contentHeight = 500.0;
    return contentHeight;
  }
}
