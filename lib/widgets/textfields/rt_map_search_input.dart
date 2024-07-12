import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';

import '../svg_widget.dart';

class RTMapSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSearchSelected;
  final Color? borderColor;
  final bool isButton;
  const RTMapSearchField(
      {super.key,
      this.controller,
      this.onSearchSelected,
      this.isButton = false,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50.0,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        color: whiteColor,
        border: Border.all(
          color: borderColor ?? primaryMaterialColor.shade300,
        ),
      ),
      child: isButton
          ? Material(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              color: Colors.transparent,
              child: InkWell(
                onTap: onSearchSelected,
                borderRadius: BorderRadius.circular(defaultBorderRadius + 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Svg(
                      path: "search-location.svg",
                      color: greyColor60,
                      size: 30.0,
                    ).paddingRight(10.0),
                    Expanded(
                      child: Text(
                        'Quelle est notre destination ?',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ).paddingHorizontal(5.0),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Svg(
                  path: "search-location.svg",
                  color: Colors.grey.shade500,
                  size: 30.0,
                ).paddingRight(10.0),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.streetAddress,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: blackColor80,
                          fontWeight: FontWeight.w500,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Quelle est notre destination ?",
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                      counterText: '',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: scaffoldColor,
                  ),
                  width: 50.0,
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Svg(
                              path: "arrow-right-2.svg",
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ).paddingHorizontal(5.0),
    );
  }
}
