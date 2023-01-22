import 'package:flutter/foundation.dart' show immutable;

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