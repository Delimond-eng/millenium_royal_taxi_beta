import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

class SubmitLoaderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final Color? bgColor;
  final bool isLoading;
  final bool disabled;
  final double? radius;
  const SubmitLoaderButton(
      {super.key,
      required this.onPressed,
      this.child,
      this.isLoading = false,
      this.bgColor,
      this.disabled = false,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        disabledBackgroundColor: Colors.grey,
        backgroundColor: bgColor ?? primaryMaterialColor.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10.0),
        ),
      ),
      onPressed: isLoading || disabled ? null : onPressed,
      child: isLoading
          ? const SpinKitChasingDots(
              color: Colors.white,
              duration: Durations.extralong1,
              size: 25.0,
            )
          : child,
    );
  }
}
