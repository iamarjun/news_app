import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocation {
  Future<Placemark> getCurrentCountry() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return placemarks[0];
  }
}
