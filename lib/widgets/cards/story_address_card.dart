import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';
import '../../screens/home/states/home_state.dart';
import '/models/story_address.dart';

class StoryAddressCard extends StatelessWidget {
  final StoryAddress item;
  const StoryAddressCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var state = Get.put(HomeState());
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 70.0,
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            color: whiteColor,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  state.animateToNextPage(1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: blackColor80,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).paddingBottom(8.0),
        ),
        Positioned(
          bottom: 0,
          right: -4,
          child: Image.asset(
            "assets/icons/tax-1.png",
            height: 40.0,
            fit: BoxFit.scaleDown,
          ).paddingBottom(10.0),
        )
      ],
    );
  }
}
