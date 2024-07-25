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
    {"label": "Moi même", "selected": false},
    {"label": "Entreprise", "selected": false},
    {"label": "Un proche", "selected": false},
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
                              'Qui paye votre course ?',
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
                                  _homeState.animateToNextPage(2);
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
