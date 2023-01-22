import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_service/repository/geolocation_repository.dart';
import 'package:location_service/views/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: RepositoryProvider(
      create: (_) => GeolocationRepository(),
      child: const HomePage(),
    ),
  ));
}
