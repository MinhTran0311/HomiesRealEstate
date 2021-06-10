import 'package:boilerplate/models/post/postProperties/postProperty.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Properties extends StatelessWidget {
  final PropertyList _propertyList;
  Properties(this._propertyList);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 120,
      child: Padding(
          padding: EdgeInsets.only(left:12, bottom:6,top: 6,right: 6),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: buildProperties(context, this._propertyList.properties,size),
          )
      ),
    );
  }
  List<Widget> buildProperties(BuildContext context, List<Property> propertyList, Size size) {
    List<Widget> list =[];

    for (var i=0;i<propertyList.length;i++){
      list.add(buildPropertyIcon(propertyList[i], i, size));

    }
    return list;
  }

  Widget buildPropertyIcon(Property appImage, int index, Size size){
    return Container(
      width: (size.width)/4.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          children: [
            propertyWidget(appImage.thuocTinhId),
            SizedBox(height: 6,),
            Flexible(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  appImage.thuocTinhTenThuocTinh,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(height: 6,),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  appImage.giaTri,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget propertyWidget(int propertyId){
    switch (propertyId){
      case 3:
        return Icon(Icons.house_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 4:
        return Icon(Icons.add_road_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 5:
        return Icon(Icons.sensor_door_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 6:
        return Icon(Icons.streetview_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 7:
        return Icon(Icons.king_bed_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 8:
        return Icon(Icons.bathtub_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 9:
        return Icon(Icons.policy_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 10:
        return Icon(Icons.weekend_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 11:
        return Icon(Icons.apartment_outlined,color: Colors.yellow[700], size:28,);
        break;
      case 12:
        return Icon(Icons.confirmation_number_outlined,color: Colors.yellow[700], size:28,);
        break;
      default:
        return Icon(Icons.category_outlined,color: Colors.yellow[700], size:28,);
        break;
    }
  }

}
