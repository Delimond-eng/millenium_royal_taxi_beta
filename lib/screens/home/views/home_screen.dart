// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/route/screen_export.dart';

import '../../../widgets/svg_widget.dart';
import '../states/home_state.dart';
import 'components/home_component.dart';
import 'components/ride_selection_component.dart';
import 'components/ride_validated_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeState homeState;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final LatLng _center = const LatLng(-4.4419311, 15.2662931);

  @override
  void initState() {
    super.initState();
    homeState = Get.put(HomeState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _menuButton(),
        centerTitle: false,
        elevation: 0,
      ),
      body: Obx(() {
        return Stack(
          children: [
            GestureDetector(
              onPanUpdate: (details) {},
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(viewInsets: EdgeInsets.zero),
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      trafficEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 18.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  );
                },
              ),
            ),
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: homeState.onPageChanged,
              controller: homeState.controller.value,
              children: const [
                HomeComponent(),
                RideSelectionComponent(),
                RideValidatedComponent()
              ],
            )
          ],
        );
      }),
    );
  }

  Widget _menuButton() {
    return SizedBox(
      height: 45,
      width: 45,
      child: Card(
        margin: EdgeInsets.zero,
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              Navigator.pushNamed(context, menuScreenRoute);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Svg(
                  path: "menu-1.svg",
                  color: Colors.black,
                  size: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateContentHeight(double maxHeight) {
    double contentHeight = 400.0;
    return contentHeight;
  }
}
