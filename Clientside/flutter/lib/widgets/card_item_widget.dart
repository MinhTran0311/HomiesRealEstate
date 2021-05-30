import 'package:boilerplate/constants/font_family.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
    @required this.colorbackgroud,
    @required this.colortext,
    @required this.coloricon,
    @required this.isFunction
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final Color colorbackgroud;
  final Color colortext;
  final Color coloricon;
  final bool isFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FlatButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: press,
            color: colorbackgroud,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: coloricon,
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(text,
                      style:
                      TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: FontFamily.roboto,
                          color: colortext)
                  ),
                ),
                !isFunction ? Icon(
                  Icons.arrow_forward_ios,
                  color: colortext,
                ) : Container(width: 0, height: 0)
              ],
            )
        ),
      ),
    );
  }
}