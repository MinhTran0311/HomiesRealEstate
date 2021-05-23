import 'dart:html';

import 'package:boilerplate/models/placeSearch.dart';
import 'package:boilerplate/services/geolocator_service.dart';
import 'package:boilerplate/services/placesService.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    // searchResults = await placesService.getAutocomplete(searchTerm);
    // print("SearchResult: " + searchResults.toString());
    // print(searchResults);
    // notifyListeners();
    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
  }
}