import 'package:flutter/material.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

class SnapBar extends StatelessWidget {
  const SnapBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: greyColor60,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
