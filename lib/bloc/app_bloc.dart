import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';
import 'bloc_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.empty()) {
    on<StartLocationService>((event, emit) async {});
  }
}
