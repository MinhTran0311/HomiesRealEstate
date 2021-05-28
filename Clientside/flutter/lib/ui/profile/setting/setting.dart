import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _SettingPageState({
    Key key,
  }) : super();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody()
          ),
        )

    );;
  }
  Widget _buildAppBar(){
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){setState(() {
            Navigator.pop(context);
          });}),
      centerTitle: true,
      title: Text("Cài đặt")
    );
  }

  Widget _buildBody(){
    return Container();
  }
}