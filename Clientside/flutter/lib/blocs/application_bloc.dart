// import 'dart:html';
import 'package:boilerplate/models/placeSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobx/mobx.dart';

class ApplicationBloc with ChangeNotifier {

  @observable
  List<Placemark> placemarks;

  @observable
  double latTit;

  @observable
  double longTit;

  @observable
  bool getSuccess = false;

  @observable
  String inputSearch;


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

}