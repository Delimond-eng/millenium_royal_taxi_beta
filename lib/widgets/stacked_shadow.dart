import 'package:flutter/material.dart';

class StackedShadow extends StatelessWidget {
  final Color? color;
  const StackedShadow({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: -8,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: 2,
              blurRadius: 30,
              offset: const Offset(0, -1), // ombre vers le haut
            ),
          ],
        ),
      ),
    );
  }
}
