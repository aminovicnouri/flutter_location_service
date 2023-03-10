import 'package:flutter/foundation.dart' show immutable;
import 'package:geolocator/geolocator.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class StartLocationService implements AppEvent {
  const StartLocationService();
}
@immutable
class StopLocationService implements AppEvent {
  const StopLocationService();
}

@immutable
class CheckPermissions implements AppEvent {
  const CheckPermissions();
}
@immutable
class RequestPermissions implements AppEvent {
  const RequestPermissions();
}

@immutable
class LocationUpdated implements AppEvent {
  final Position position;

  const LocationUpdated({required this.position});
}