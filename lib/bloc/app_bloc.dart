import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


import 'app_state.dart';
import 'bloc_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.empty()) {
    on<StartLocationService>((event, emit) async {

    });
  }
}
