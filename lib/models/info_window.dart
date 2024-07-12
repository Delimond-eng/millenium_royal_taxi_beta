import 'package:google_maps_flutter/google_maps_flutter.dart';

enum InfoWindowType { position, destination }

class InfoWindowModel {
  final String? name;
  final Duration? time;
  final LatLng? position;
  final InfoWindowType type;

  const InfoWindowModel(
      {this.name, this.time, this.position, required this.type});
}
