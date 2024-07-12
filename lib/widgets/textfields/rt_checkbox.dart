import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

class RTCheckbox extends StatelessWidget {
  final String? title;
  final bool isChecked;
  final VoidCallback? onChecked;
  final Color? color;
  const RTCheckbox(
      {super.key,
      this.title,
      this.isChecked = false,
      this.onChecked,
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 25.0,
            width: 25.0,
            margin: const EdgeInsets.only(right: 5.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isChecked ? primaryColor : color ?? greyColor60,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: isChecked
                ? AnimatedContainer(
                    duration: Durations.long3,
                    margin: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.circle_fill,
                          color: Colors.white,
                          size: 5.0,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Flexible(
            child: Text(
              title!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isChecked ? primaryColor : color ?? blackColor80,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
