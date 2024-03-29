import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/kiemduyet/kiemduyet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }
  ThemeStore _themeStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Trợ Giúp",
      ),),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildMenuItems();
      },
    );
  }

  Widget _buildMenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.08, 0.08, 1],
            colors: [
              Color.fromRGBO(230, 145, 56, 1),
              Colors.amberAccent,
              // Color.fromRGBO(236, 236, 238, 1),
              // Color.fromRGBO(236, 236, 238, 1),
              _themeStore.darkMode ? AppColors.backgroundDarkThemeColor : AppColors.backgroundLightThemeColor,
              _themeStore.darkMode ? AppColors.backgroundDarkThemeColor : AppColors.backgroundLightThemeColor,
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 18),
              width: MediaQuery.of(context).size.width*0.95,
              // height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  // color: Colors.white, //background color of box
                  !_themeStore.darkMode ? BoxShadow(
                    color: Color.fromRGBO(198, 199, 202, 1),
                    blurRadius: 12, // soften the shadow
                    spreadRadius: 0.01, //extend the shadow
                    offset: Offset(
                      8.0, // Move to right 10  horizontally
                      12.0, // Move to bottom 10 Vertically
                    ),
                  ) : BoxShadow(),
                ],
                color: _themeStore.darkMode ? AppColors.darkBlueForCardDarkTheme : AppColors.greyForCardLightTheme,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/analytics.png',
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bạn có thể liên hệ trợ giúp theo những cách sau:",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            _buildListItem("FaceBook", "assets/images/fb.jpg", "Facebook QTV",
                _clickBtnfb, Colors.lightBlueAccent, 0),
            SizedBox(
              height: 25,
            ),
            _buildListItem("Gmail", "assets/images/gm.jpg", "Gmail hỗ trợ",
                _clickBtngm, Colors.redAccent, 0),
            SizedBox(
              height: 25,
            ),
            _buildListItem("Hotline", "assets/images/tl.png",
                "Gọi điện cho tổng đài", _clickBtntl, Colors.lightBlueAccent, 0),
            SizedBox(
              height: 25,
            ),
            _buildListItem("Tổng đài tin nhắn", "assets/images/ms.png",
                "Nhắn tin cho tổng đài", _clickBtnms, Colors.amber[700], 0),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String nameItem, String pathPicture, String nameButton,
      Function function, Color colors, double leftPadding) {
    return Container(
      decoration: !_themeStore.darkMode ? new BoxDecoration(
        boxShadow: [
          // color: Colors.white, //background color of box
          BoxShadow(
            color: Color.fromRGBO(198, 199, 202, 1),
            blurRadius: 12, // soften the shadow
            spreadRadius: 0.01, //extend the shadow
            offset: Offset(
              8.0, // Move to right 10  horizontally
              12.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ) : new BoxDecoration(),
      child: Card(
        margin: EdgeInsets.only(top: 8, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          color:!_themeStore.darkMode?Colors.white:Color.fromRGBO(18, 22, 28, 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colors,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(left: leftPadding),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 3),
                      color: colors,
                    ),
                    //\\\ backgroundColor: colors,
                    child: Image.asset(
                      pathPicture,
                      width: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nameItem,
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(width: 15,),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      ElevatedButton(
                        child: Text(nameButton.toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(colors),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: colors)))),
                        onPressed: function,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _clickBtnfb() {
    _launchURL();
  }

  _launchURL() async {
     _openUrl ( 'https://www.facebook.com/thoconxinhxan.nhinvexaxam/');
  }

  _clickBtngm() {
    _launchgm();
  }

  _launchgm() async {
    setState(() {
      _openUrl('mailto:18520096@gmail.com');
    });
  }

  _clickBtntl() {
    _launchtl();
  }

  _launchtl() async {
    _openUrl('tel:+84349156877');
  }

  _clickBtnms() {
    _launchms();
  }

  _launchms() async {
    _openUrl('sms:0349156877?body=xin chào');
  }
}
