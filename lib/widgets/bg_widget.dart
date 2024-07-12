import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBg extends StatelessWidget {
  final double? radius;
  final Widget child;
  final double? graduation;
  const GlassBg({super.key, this.radius, required this.child, this.graduation});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: graduation ?? 4.0,
          sigmaY: graduation ?? 4.0,
        ),
        child: child,
      ),
    );
  }
}
