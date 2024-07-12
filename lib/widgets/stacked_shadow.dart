import 'package:flutter/material.dart';

import '../constants/styles.dart';

class StackedShadow extends StatelessWidget {
  final Color? color;
  const StackedShadow({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: -8,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 14.0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: color ?? primaryColor.withOpacity(.8),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
