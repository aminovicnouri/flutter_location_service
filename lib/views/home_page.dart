import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_service/bloc/bloc_event.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_state.dart';
import '../repository/geolocation_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        geolocationRepository: context.read<GeolocationRepository>(),
      )..add(const CheckPermissions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, appState) {
            switch (appState.permissionState) {
              case LocationPermissionState.granted:
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<AppBloc>().add(
                              !appState.serviceIsRunning
                                  ? const StartLocationService()
                                  : const StopLocationService(),
                            );
                      },
                      child: !appState.serviceIsRunning
                          ? const Text('Start location service')
                          : const Text('Stop location service'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: appState.positions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${index+1} : ${appState.positions[index].latitude},${appState.positions[index].longitude}',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              case LocationPermissionState.denied:
                return Center(
                  child: TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                        const RequestPermissions(),
                      );
                    },
                    child: const Text('Request permissions'),
                  ),
                );
              case LocationPermissionState.deniedForever:
                return const Center(
                  child: Text('Permissions permanently denied.'),
                );
              case LocationPermissionState.locationServiceDisabled:
                return const Center(
                  child: Text('Location service disabled.'),
                );
              case null:
                return Center(
                  child: TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                        const RequestPermissions(),
                      );
                    },
                    child: const Text('Request permissions'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
