import 'package:geolocator/geolocator.dart';
import 'package:location_service/repository/base_geolocation_repository.dart';

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Stream<Position> getPositionStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
