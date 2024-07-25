import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/screens/home/states/home_state.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../../../../widgets/buttons/submit_loader_btn.dart';
import '../../../../widgets/textfields/rt_checkbox.dart';

class RideTypeComponent extends StatefulWidget {
  const RideTypeComponent({super.key});

  @override
  State<RideTypeComponent> createState() => _RideTypeComponentState();
}

class _RideTypeComponentState extends State<RideTypeComponent> {
  List<Map<String, dynamic>> rideTypes = [
    {"label": "Course standard", "selected": false},
    {"label": "Co-voiturage", "selected": false},
    {"label": "Delivery", "selected": false},
  ];
  bool isSelectedOne = false;
  late HomeState _homeState;

  @override
  void initState() {
    super.initState();
    _homeState = Get.put(HomeState());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeIn(
          child: DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.22,
            maxChildSize: 0.22,
            snap: false,
            expand: false,
            builder: (BuildContext context, scrollSheetController) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    top: -30,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Veuillez sélectioner le type de course !',
                              style: TextStyle(
                                color: darkColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: darkColor,
                      elevation: 10.0,
                      shadowColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/ride-taxi.png",
                                    fit: BoxFit.scaleDown,
                                  ).paddingRight(10.0),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        for (var e in rideTypes) ...[
                                          RTCheckbox(
                                            color: blackColor60,
                                            isChecked: e['selected'],
                                            fSize: 16.0,
                                            onChecked: () {
                                              for (var el in rideTypes) {
                                                el['selected'] = false;
                                              }
                                              e['selected'] = !e['selected'];
                                              setState(() {
                                                if (e['selected']) {
                                                  isSelectedOne = true;
                                                } else {
                                                  isSelectedOne = false;
                                                }
                                              });
                                            },
                                            title: e['label'],
                                          ).paddingBottom(10.0),
                                        ]
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                              child: SubmitLoaderButton(
                                disabled: !isSelectedOne,
                                child: Text(
                                  "Continuer",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: whiteColor,
                                      ),
                                ),
                                onPressed: () {
                                  _homeState.animateToNextPage(1);
                                },
                              ).paddingHorizontal(10.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
