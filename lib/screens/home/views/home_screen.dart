// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/route/screen_export.dart';
import 'package:royal_taxi_beta/screens/home/views/components/ride_type_component.dart';
import 'package:royal_taxi_beta/screens/home/views/components/rider_payment_component.dart';
import 'package:royal_taxi_beta/screens/home/views/components/rider_payment_mode.dart';

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

  late Location location;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final LatLng _center = const LatLng(-4.326277, 15.326688);

  @override
  void initState() {
    super.initState();
    homeState = Get.put(HomeState());
    // SchedulerBinding.instance.addPostFrameCallback((_) {

    // });

    // location = Location();
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {
    //     _center = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //   });
    // });
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
                    child: Image.asset("assets/images/map.png"),
                  );
                },
              ),
            ),
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: homeState.onPageChanged,
              controller: homeState.controller.value,
              children: const [
                RideTypeComponent(),
                RidePaymentComponent(),
                RiderPaymentMode(),
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

  GoogleMap _mapViewer() {
    return GoogleMap(
      mapType: MapType.normal,
      trafficEnabled: true,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 16.5,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
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
