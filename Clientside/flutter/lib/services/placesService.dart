import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:boilerplate/models/placeSearch.dart';

class PlacesService {
  final key = "AIzaSyDVRIkTGy0e4on9CcyqAB1TbDByILoso3Q";

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=pt_BR&key=$key";
    var response = await http.get(url);
    print("response:" + response.toString());
    print(response);
    var json = convert.jsonDecode(response.body);
    print("response.body:" + response.body.toString());
    print(response.body);
    var jsonResults = json["predictions"] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}