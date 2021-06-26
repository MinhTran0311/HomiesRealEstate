// import 'dart:html';
import 'package:boilerplate/models/placeSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

class ApplicationBloc with ChangeNotifier {

  @observable
  List<Placemark> placemarks;

  @observable
  List<Location> placemarksFromPlaces = new List<Location>();

  @observable
  double latTit;

  @observable
  double longTit;

  @observable
  bool getSuccess = false;

  @observable
  bool getSuccessFromPlaces = false;

  @observable
  String inputSearch;

  @observable
  LatLng postNewCurrent;


  @action
  searchPlaces(String searchTerm) async {
    getSuccess = false;
    latTit = null;
    longTit = null;
    this.inputSearch = searchTerm;
    String handlingResult = searchTerm.trim().replaceAll("\n", "").replaceAll("\t", "").replaceAll(" ", "");
    int indexOfCut = handlingResult.indexOf(",");
    if (indexOfCut == -1) {
      return;
    }
    else {
      latTit = double.tryParse(handlingResult.substring(0, indexOfCut));
      longTit = double.tryParse(handlingResult.substring(indexOfCut+1));
      getSuccess = false;
      if (latTit != null || longTit != null) {
        try {
         placemarks = await placemarkFromCoordinates(latTit, longTit);
        }
        catch(e) {
          throw e;
        }
        if (placemarks != null) {
          // print("placemarks" + placemarks.length.toString());
          getSuccess = true;
        }
      }
    }
  }
  @action
  searchFromPlace(String searchTerm) async {
    getSuccessFromPlaces = false;
    try {
      placemarksFromPlaces.clear();
      placemarksFromPlaces = await locationFromAddress(searchTerm);
    }
    catch(e) {
      throw e;
    }
    if (placemarksFromPlaces[0] != null) {
      print(".....");
      postNewCurrent = LatLng(placemarksFromPlaces[0].latitude, placemarksFromPlaces[0].longitude);
      print(postNewCurrent);
      getSuccessFromPlaces = true;
    }
  }

}