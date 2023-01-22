import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepository {
  Stream<Position> getPositionStream();
}