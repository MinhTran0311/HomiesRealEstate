import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:boilerplate/ui/profile/mypost/editpost/editpost.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';

class MyPostScreen extends StatefulWidget {
  final UserStore userStore;
  final PostStore postStore;
  MyPostScreen({@required this.userStore, this.postStore});
  @override
  _MyPostScreenState createState() =>
      _MyPostScreenState(userStore: userStore, postStore: postStore);
}

class _MyPostScreenState extends State<MyPostScreen> {
  final UserStore userStore;
  final PostStore postStore;
  _MyPostScreenState({@required this.userStore, this.postStore});
  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  LanguageStore _languageStore;
  TownStore _townStore;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _townStore = Provider.of<TownStore>(context);
    if (!postStore.loadingPostForCur) {
      postStore.getPostForCurs();
    }
    if (!userStore.loading) userStore.getCurrentUser();
    if (!_townStore.loading) {
      _townStore.getTowns();
    }
    if (!_townStore.loadingCommune) {
      _townStore.getCommunes();
    }
    if (!postStore.loadingPack) {
      postStore.getPacks();
    }
    if (!postStore.loadingThuocTinh) {
      postStore.getThuocTinhs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Icon: Icons.app_registration,
        backgroundColor: Colors.amber[400],
        title: Text(
          "Bài đăng của tôi",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white,
              fontSize: 23,
              // backgroundColor:Colors.amber ,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget buildFilter(String filterName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          )),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Widget _buildLogoutButton() {
  //   return IconButton(
  //     onPressed: () {
  //       SharedPreferences.getInstance().then((preference) {
  //         preference.setBool(Preferences.is_logged_in, false);
  //         preference.setBool(Preferences.auth_token, false);
  //         //_authTokenStore.loggedIn=false;
  //         Navigator.of(context).pushReplacementNamed(Routes.login);
  //       });
  //     },
  //     icon: Icon(
  //       Icons.power_settings_new,
  //     ),
  //   );
  // }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(children: <Widget>[
      _handleErrorMessage(),
      _buildMainContent(),
    ]);
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return postStore.loadingPostForCur
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildPostsList());
      },
    );
  }

  Widget _buildPostsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 16),
          child: TextField(
            style: TextStyle(
              fontSize: 28,
              height: 1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 28,
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  child: Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          buildFilter('Loại nhà'),
                          buildFilter('Giá'),
                          buildFilter('Phòng ngủ'),
                          buildFilter('Hồ bơi'),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 28,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  stops: [
                                0.0,
                                0.1
                              ],
                                  colors: [
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.0),
                              ])),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 24),
                  child: Text(
                    'filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return postStore.postForCurList != null
        ? Expanded(
            child: ListView.separated(
              itemCount: postStore.postForCurList.posts.length,
              separatorBuilder: (context, position) {
                return Divider();
              },
              itemBuilder: (context, position) {
                return _buildPostPoster(
                    postStore.postForCurList.posts[position], position);
                //_buildListItem(position);
              },
            ),
          )
        : Center(
            child: Text(
              "chưa có bài đăng",
            ),
          );
  }

  Widget _buildPostPoster(Post post, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 24, right: 10, left: 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Detail(post: post)));
          },
          child: Container(
            height: 210,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: post.featuredImage != null
                  ? NetworkImage(post.featuredImage)
                  : AssetImage(Assets.front_img),
              fit: BoxFit.cover,
            )),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0.5,
                    1.0
                  ],
                      colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 80,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Center(
                          child: Text(
                            post.tagLoaiBaidang,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: DateTime.now()
                                    .isAfter(DateTime.parse(post.thoiHan))
                                ? Colors.red[700]
                                : Colors.green[600],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 80,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Center(
                            child: DateTime.now()
                                    .isAfter(DateTime.parse(post.thoiHan))
                                ? Text("Hết hạn",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))
                                : Text("Còn Hạn",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              post.tieuDe,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            post.gia.toString() + "VND",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                post.tenXa,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.zoom_out_map,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                post.dienTich.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                post.diemBaiDang.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditpostScreen(
                                post: post,
                                townStore: _townStore,
                                postStore: postStore,
                                userStore: userStore,
                              )));
                }),
            MaterialButton(

                    child: Text("Gia hạn"),
                      onPressed: (){
                                showGiaHanDialog(context,post);
                    },
                    ),
            IconButton(icon: const Icon(Icons.delete), onPressed: null),
          ],
        )
      ]),
    );
  }

  var songay;
  DateTime selectedDatefl = null;
  _selectDatefl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('en', ''),
      initialDate: selectedDatefl,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDatefl)
      setState(() {
        selectedDatefl = picked;
        songay = 0;
        while (selectedDatefl
            .isAfter(DateTime.now().add(Duration(days: songay)))) songay++;
      });
  }

  showGiaHanDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gia hạn bài đăng"),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Ngày hết hạn: ${post.thoiHan.split("T")[0]} ${post.thoiHan.split("T")[1].split(".")[0]}"),
                Text(""),
                RoundedButtonWidget(
                  onPressed: () => _selectDatefl(context),
                  buttonColor: Colors.orangeAccent,
                  textColor: Colors.white,
                  buttonText: ('Chọn ngày kết thúc'),
                ),
              ]),
        );
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (postStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(postStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        });
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
