import 'package:animate_do/animate_do.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';
import 'package:royal_taxi_beta/widgets/stacked_shadow.dart';

import '../../../../constants/my_address.dart';
import '../../../../widgets/cards/course_option_card.dart';
import '../../../../widgets/cards/story_address_card.dart';
import '../../../../widgets/snap_bar.dart';
import '../../../../widgets/textfields/rt_map_search_input.dart';
import '../../modals/address_pick_modal.dart';
import '../../states/home_state.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    var state = Get.put(HomeState());
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentHeight = calculateContentHeight(constraints.maxHeight);
        final minChildSize = contentHeight / constraints.maxHeight;
        return FadeIn(
          child: DraggableScrollableSheet(
            initialChildSize: minChildSize,
            minChildSize: minChildSize,
            maxChildSize: 0.55,
            snap: false,
            expand: false,
            builder: (BuildContext context, scrollSheetController) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  const StackedShadow(
                    color: Color.fromARGB(255, 186, 204, 247),
                  ),
                  Positioned.fill(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: scaffoldColor,
                      elevation: 10.0,
                      shadowColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                      child: ListView(
                        controller: scrollSheetController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          const SnapBar(),
                          RTMapSearchField(
                            isButton: true,
                            borderColor: greyColor40,
                            onSearchSelected: () {
                              showAddressPickBottomSheetModal(context);
                            },
                          ).paddingHorizontal(10.0),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineThickness: 1,
                            dashLength: 4,
                            dashColor: Colors.grey.shade400,
                          ).paddingVertical(10.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: CourseCard(
                                    title: "Voiture",
                                    icon: "assets/icons/car-4.png",
                                    colors: const [
                                      Color.fromARGB(255, 123, 52, 19),
                                      Color(0xFF2e0505),
                                    ],
                                    onSelected: () {
                                      state.animateToNextPage(1);
                                    },
                                  ).paddingRight(10.0),
                                ),
                                Flexible(
                                  child: CourseCard(
                                    title: "Moto",
                                    colors: const [
                                      primaryColor,
                                      Colors.brown,
                                    ],
                                    icon: "assets/icons/moto-1.png",
                                    onSelected: () {
                                      state.animateToNextPage(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineThickness: .4,
                            dashLength: 4,
                            dashColor: Colors.grey.shade300,
                          ).paddingVertical(10.0),
                          Column(
                            children: destinations
                                .map((el) => StoryAddressCard(item: el))
                                .toList(),
                          ).paddingHorizontal(10.0)
                        ],
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

  double calculateContentHeight(double maxHeight) {
    double contentHeight = 200.0;
    return contentHeight;
  }

  Widget buildShadowContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 20,
    );
  }
}
