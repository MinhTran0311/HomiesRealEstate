import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


part 'map_store.g.dart';

class MapsStore = _MapsStore with _$MapsStore;

abstract class _MapsStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _MapsStore(Repository repository) : this._repository = repository;

  @observable
  bool isLocationServiceEnabled;

  @observable
  Position positionCurrent;

  @observable
  CameraPosition cameraPositionCurrent;

  Future checkPermission() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    else if (checkPermission == LocationPermission.denied)
    {
      LocationPermission permission = await Geolocator.requestPermission();
    }
    // print(checkPermission);
    else if (checkPermission == LocationPermission.always || checkPermission == LocationPermission.whileInUse)
    {
      isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        await Geolocator.openAppSettings();
      }
      else {
        this.positionCurrent =  await Geolocator.getCurrentPosition();
        cameraPositionCurrent = CameraPosition(
          target: LatLng(positionCurrent.latitude, positionCurrent.longitude),
          tilt: 59.440,
          zoom: 14.5,
        );
      }
    }
  }

}