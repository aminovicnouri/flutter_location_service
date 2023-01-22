import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_service/bloc/bloc_event.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {},
          builder: (context, appState) {
            final location = appState.locations;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<AppBloc>().add(
                      const StartLocationService(),
                    );
                  },
                  child: const Text('Start location service'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AppBloc>().add(
                      const StopLocationService(),
                    );
                  },
                  child: const Text('Stop location service'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
