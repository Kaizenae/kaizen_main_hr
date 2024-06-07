import 'package:geolocator/geolocator.dart';

class LocationServices {
  static Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
