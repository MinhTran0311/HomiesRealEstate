import 'dart:math';

class local_Converter{
  String PriceFormat(double price){
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

}