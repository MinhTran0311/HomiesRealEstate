import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  CardItem({
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
  ThemeStore _themeStore;
  @override
  Widget build(BuildContext context) {
    _themeStore = Provider.of<ThemeStore>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FlatButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: press,
            color: colorbackgroud ?? (_themeStore.darkMode ? Color.fromRGBO(30, 32, 38, 1) : Colors.grey[200]),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: coloricon ?? Colors.amber,
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(text,
                      style:
                      TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                          color: colortext ?? ((_themeStore.darkMode ? Colors.white : Colors.black))
                      )
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