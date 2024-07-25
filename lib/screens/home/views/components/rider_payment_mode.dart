import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../../../../constants/styles.dart';
import '../../states/home_state.dart';

class RiderPaymentMode extends StatefulWidget {
  const RiderPaymentMode({super.key});

  @override
  State<RiderPaymentMode> createState() => _RiderPaymentModeState();
}

class _RiderPaymentModeState extends State<RiderPaymentMode> {
  List<Map<String, dynamic>> modes = [
    {"icon": "assets/logo/wallet.png", "selected": false},
    {"icon": "assets/logo/mpesa.png", "selected": false},
    {"icon": "assets/logo/airtel_money.png", "selected": false},
    {"icon": "assets/logo/orange_money.png", "selected": false},
    {"icon": "assets/logo/visa-mastercard.jpg", "selected": false},
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
                              'Sélectionnez un mode de paiement !',
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/pay-concept.png",
                                    fit: BoxFit.scaleDown,
                                  ).paddingRight(10.0),
                                  Expanded(
                                    child: GridView.builder(
                                      controller: scrollSheetController,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1.8,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemCount: modes.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var e = modes[index];
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          margin: EdgeInsets.zero,
                                          child: Material(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              onTap: () {
                                                _homeState.animateToNextPage(3);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  e["icon"],
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
