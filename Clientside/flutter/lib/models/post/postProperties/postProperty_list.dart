import 'package:boilerplate/models/post/postProperties/postProperty.dart';

class PropertyList {
  final List<Property> properties;

  PropertyList({
    this.properties,
  });

  factory PropertyList.fromJson(Map<String, dynamic> json) {
    List<Property> properties = List<Property>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      properties.add(Property.fromMap(json["result"]["items"][i]));
    }
    return PropertyList(
      properties: properties,
    );
  }
}
