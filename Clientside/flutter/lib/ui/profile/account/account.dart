import 'package:boilerplate/constants/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget{
  const Account({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.Address,
  }) : super(key: key);
  final String Phone,Email,Address;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 360,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Container(
                width: 200,
                height: 200,
                // color: Colors.grey[400],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.grey[300],width: 0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child:
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Giới thiệu",
                            style: TextStyle(
                              fontFamily: FontFamily.roboto,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24
                            ),
                          ),
                          TextIcon(icon: Icons.phone, text: Phone),
                          TextIcon(icon: Icons.mail, text: Email),
                          TextIcon(icon: Icons.location_on, text: Address)
                        ],
                      ),
                    )
              ),
            ),
          ),
          Container(
            color: Colors.white,
              padding: const EdgeInsets.only(left: 30),
              child: TextIcon(icon: Icons.access_time_outlined, text: "Đã tham gia Tháng 3 Năm 2021")
          )
        ],
      ),
    );
  }
}
class TextIcon extends StatelessWidget{
  const TextIcon({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10),
      child: Row(
        children: [
          Icon(icon,color: Colors.orange),
          Text(" "+text,
            style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.roboto,
                color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}