// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomDraggableScrollableSheet extends StatefulWidget {
  final List<Widget> child;
  const CustomDraggableScrollableSheet({
    super.key,
    required this.child,
  });

  @override
  State<CustomDraggableScrollableSheet> createState() =>
      _CustomDraggableScrollableSheetState();
}

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  final GlobalKey _childKey = GlobalKey();
  double initialChildSize = 0.2;
  double minChildSize = 0.2;
  double maxChildSize = 0.9;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSizes();
    });
  }

  void _calculateSizes() {
    final RenderBox renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox;
    if (renderBox != null) {
      final double height = renderBox.size.height;
      final double screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        initialChildSize = (height / screenHeight).clamp(0.2, 0.9);
        minChildSize = initialChildSize;
        maxChildSize = 0.9;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          snap: false,
          expand: false,
          builder: (BuildContext context, scrollSheetController) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: darkColor,
                    elevation: 10.0,
                    key: _childKey,
                    shadowColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      controller: scrollSheetController,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: widget.child,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
