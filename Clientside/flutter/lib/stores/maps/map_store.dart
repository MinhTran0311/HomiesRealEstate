import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';


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
  PostList postListAll;

  @observable
  Post postClickMarker;

  @observable
  LatLng tapPointClick = new LatLng(0, 0);

  @observable
  CameraPosition cameraPositionCurrent;

  @observable
  Set<Marker> markers = new Set<Marker>();

  static ObservableFuture<PostList> emptyPostResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<PostList> fetchPostsFuture =
  ObservableFuture<PostList>(emptyPostResponse);

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  @action
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
        await Geolocator.openLocationSettings();
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

  @action
  Future getAllPosts() {
    final future = _repository.getAllPosts();
    fetchPostsFuture = ObservableFuture(future);

    future.then((postList) {
      this.postListAll = postList;
      for (int i = 0; i < postList.posts.length; i++)
      {
        markers.add(Marker(
          markerId: MarkerId(postList.posts[i].id.toString()),
          position: LatLng(double.tryParse(postList.posts[i].toaDoX),
              double.tryParse(postList.posts[i].toaDoY)),
          infoWindow: InfoWindow(
            title: '${postList.posts[i].tagLoaiBaidang}',
            snippet: priceFormat(postList.posts[i].gia),
          ),
          onTap: () {
            this.postClickMarker = postList.posts[i];
          },
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
        throw error;
      }
    });
  }

}