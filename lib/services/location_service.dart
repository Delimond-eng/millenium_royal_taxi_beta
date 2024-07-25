import 'package:location/location.dart';

class LocationService {
  static Future<LocationData?> getLocationData() async {
    Location location = new Location();
    var isGranted = await requestAllow();
    if (isGranted) {
      LocationData? locationData;
      locationData = await location.getLocation();
      return locationData;
    }
    return null;
  }

  static Future<bool> requestAllow() async {
    Location location = Location();

    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location service is not enabled.");
        return false;
      }
    }

    // Check if location permission is granted
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission not granted.");
        return false;
      }
    }
    return true;
  }
}
