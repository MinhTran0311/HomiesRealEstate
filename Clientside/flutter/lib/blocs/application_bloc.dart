// import 'dart:html';
import 'package:boilerplate/models/placeSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ApplicationBloc with ChangeNotifier {
  // final geoLocatorService = GeolocatorService();
  // final placesService = PlacesService();
  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  List<Placemark> placemarks;
  List<Placemark> placemark;
  double latTit;
  double longTit;
  bool getSuccess = false;
  String inputSearch;

  //
  // ApplicationBloc() {
  //   setCurrentLocation();
  // }

  // setCurrentLocation() async {
  //   currentLocation = await geoLocatorService.getCurrentLocation();
  //   notifyListeners();
  // }

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
    // print(handlingResult);
    // String latTit =
    // searchResults = await placesService.getAutocomplete(searchTerm);
    // print("SearchResult: " + searchResults.toString());
    // print(searchResults);
    // notifyListeners();
    // List<Location> locations = await locationFromAddress("searchTerm");
  }

  searchPlace(double lat, double long) async {
    getSuccess = false;
    if (lat != null || long != null) {
      try {
        placemark = await placemarkFromCoordinates(lat, long);
      }
      catch(e) {
        throw e;
      }
      if (placemark != null) {
        // print("placemarks" + placemarks.length.toString());
        getSuccess = true;
      }
    }
  }
}