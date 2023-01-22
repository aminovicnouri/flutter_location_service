import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState {
  final String locations;

  const AppState({
    required this.locations,
  });

  const AppState.empty(): locations = '';
}

