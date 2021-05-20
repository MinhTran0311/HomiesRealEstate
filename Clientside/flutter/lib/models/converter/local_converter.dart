import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

String priceFormat(double price){
  var array = ['','Ngàn','Triệu','Tỷ','Ngàn Tỷ', 'Triệu Tỷ', 'Tỷ Tỷ'];
  int position = 0;
  for (position=0; position<6; position++){
    if (price.abs() < pow(1000,position)*1000){
      break;
    }
  }
  price /= pow(1000,position);
  price = double.parse(price.toStringAsFixed(2));
  return price.toString() + ' ' + array[position];
}

Image imageFromBase64String(String base64String) {
  Uint8List bytes = base64.decode(base64String);
  return Image.memory(bytes);
}

