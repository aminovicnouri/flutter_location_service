import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' show Position;
import 'package:location_service/bloc/permissions.dart';
import '../repository/geolocation_repository.dart';
import 'app_state.dart';
import 'bloc_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;

  AppBloc({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(const AppState.empty()) {
    on<StartLocationService>((event, emit) async {
      _geolocationSubscription?.cancel();
      _listenToLocationChanges();
      emit(
        AppState(
            positions: state.positions,
            serviceIsRunning: true,
            permissionState: state.permissionState),
      );
    });
    on<StopLocationService>((event, emit) async {
      _geolocationSubscription?.cancel();
      emit(
        AppState(
            positions: const [],
            serviceIsRunning: false,
            permissionState: state.permissionState),
      );
    });

    on<LocationUpdated>((event, emit) {
      final positions = List<Position>.from(state.positions)
        ..add(event.position);
      emit(
        AppState(
          positions: positions,
          serviceIsRunning: state.serviceIsRunning,
          permissionState: state.permissionState,
        ),
      );
    });

    on<CheckPermissions>((event, emit) async {
      final status = await checkPermissions();
      emit(
        AppState(
            positions: state.positions,
            serviceIsRunning: state.serviceIsRunning,
            permissionState: status),
      );
    });

    on<RequestPermissions>((event, emit) async {
       await requestPermissions();
       add(const CheckPermissions());
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }

  void _listenToLocationChanges() {
    _geolocationSubscription =
        _geolocationRepository.getPositionStream().listen(
      (Position? position) {
        if (position != null) {
          add(LocationUpdated(position: position));
        }
      },
    );
  }
}
