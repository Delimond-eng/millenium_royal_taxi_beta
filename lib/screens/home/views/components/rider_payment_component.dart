import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/buttons/submit_loader_btn.dart';
import '../../../../widgets/textfields/rt_checkbox.dart';
import '../../states/home_state.dart';
import '/theme/app_theme.dart';

import '../../../../constants/styles.dart';

class RidePaymentComponent extends StatefulWidget {
  const RidePaymentComponent({super.key});

  @override
  State<RidePaymentComponent> createState() => _RidePaymentComponentState();
}

class _RidePaymentComponentState extends State<RidePaymentComponent> {
  List<Map<String, dynamic>> payModes = [
    {"label": "Moi même qui paye.", "selected": false, "index": 0},
    {"label": "Entreprise qui paye.", "selected": false, "index": 1},
    {"label": "Un proche qui paye.", "selected": false, "index": 2},
  ];
  bool isSelectedOne = false;
  int selectedIndex = 0;
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
        return FadeInUp(
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
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Qui paye votre course ?',
                              style: TextStyle(
                                color: darkColor,
                                fontWeight: FontWeight.w800,
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
                                    "assets/images/question-people.png",
                                    fit: BoxFit.scaleDown,
                                  ).paddingRight(20.0),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        for (var e in payModes) ...[
                                          RTCheckbox(
                                            color: blackColor60,
                                            isChecked: e['selected'],
                                            fSize: 16.0,
                                            onChecked: () {
                                              for (var el in payModes) {
                                                el['selected'] = false;
                                              }
                                              e['selected'] = !e['selected'];
                                              selectedIndex = e['index'];
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
                                radius: 20.0,
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
                                  if (selectedIndex == 0) {
                                    _homeState.animateToNextPage(2);
                                  } else {
                                    _homeState.animateToNextPage(3);
                                  }
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
