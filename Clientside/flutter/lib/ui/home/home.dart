import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/di/permissions/permission.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/post/filter_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  //stores:---------------------------------------------------------------------
  PostStore _postStore;
  ThemeStore _themeStore;
  LanguageStore _languageStore;
  //AuthTokenStore _authTokenStore;
  UserStore userStore;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  bool isRefreshing = false;
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _postStore = Provider.of<PostStore>(context);
    userStore = Provider.of<UserStore>(context);
    //_authTokenStore = Provider.of<AuthTokenStore>(context);
    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts(false);
      _postStore.isIntialLoading = true;
      //_postStore.isIntialLoading=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        actions: _buildActions(context),
      ),
      body: _buildBody(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      if (!Permission.instance.hasPermission("Pages") || Preferences.userRole.isEmpty || Preferences.userRoleRank==0 || Preferences.auth_token.isEmpty)
        _buildLogInButton(),
    ];
  }

  Widget _buildLogInButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          preference.setString(Preferences.auth_token, "");
          preference.setString(Preferences.userRole, "");
          preference.setInt(Preferences.userRoleRank.toString(), 0);
        });
        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));

      },
      icon: Icon(
        Icons.login_outlined,
      ),
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
        return _postStore.loading
            ? CustomProgressIndicatorWidget()
            : _buildPostsList();
      },
    );
  }

  Widget _buildPostsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6, left: 24, right: 24, bottom: 12),
          child: TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            controller: _searchController,
            onChanged: (value) {
              print("123");
              print(value);


              _postStore.filter_model.searchContent = value;
              _postStore.setSearchContent(_searchController.text);
            },

            style: TextStyle(
              fontSize: 28,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 28,
                    ),
                    onPressed: () {
                      _postStore.getPosts(false);
                    },
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 24),
              child: Row(
                children: [
                  Text(
                    'Hiển thị bộ lọc nâng cao',
                    style: TextStyle(
                      fontSize: 16,
                      color: (_postStore.filter_model == null || _postStore.isNotUsingFilter) ? Colors.grey : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: (_postStore.filter_model == null || _postStore.isNotUsingFilter) ? Colors.amber : Colors.red,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(child: _buildListView()),
      ],
    );
  }

  Widget _buildListView() {
    return (_postStore.postList != null)
        ? SmartRefresher(
            //key: _refresherKey,
            controller: _refreshController,
            enablePullUp: true,
            enablePullDown: true,
            header: WaterDropHeader(
              refresh: SizedBox(
                width: 25.0,
                height: 25.0,
                child: Icon(
                  Icons.flight_takeoff_outlined,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              idleIcon: SizedBox(
                width: 25.0,
                height: 25.0,
                child: Icon(
                  Icons.flight_takeoff_outlined,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              waterDropColor: Colors.amber,
            ),
            physics: BouncingScrollPhysics(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              completeDuration: Duration(seconds: 2),
            ),
            onLoading: () async {
              _postStore.getPosts(true);
              await Future.delayed(Duration(milliseconds: 2000));
              if (mounted) {
                setState(() {});
              }
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
              _refreshController.loadComplete();
            },
            onRefresh: () async {
              _postStore.getPosts(false);

              await Future.delayed(Duration(milliseconds: 2000));
              if (mounted) setState(() {});
              isRefreshing = true;
              _refreshController.refreshCompleted();
            },
            primary: false,
            child: ListView.builder(
              //key: _contentKey,
              controller: _scrollController,
              itemCount: _postStore.postList.posts.length,
              // separatorBuilder: (context, position) {
              //   return Divider();
              // },
              itemBuilder: (context, position) {
                return _buildPostPoster(
                    _postStore.postList.posts[position], position);
                //_buildListItem(position);
              },
            ),
          )
        : Center(
            child: Text(
              "Không có bài đăng",
            ),
          );
  }

  Widget _buildPostPoster(Post post, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detail(post: post)));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
              image: DecorationImage(
            //image: NetworkImage("https://i.ibb.co/86vSMN3/download-2.jpg"),
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
                  0.3,
                  1.0
                ],
                    colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: post.tagLoaiBaidang!="Cho thuê" ? Colors.yellow[700]:Colors.lightBlueAccent,
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
                Expanded(child: Container()),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                        child: Text(
                          post.tieuDe,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),

                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            post.dienTich.toString() + ' m2',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            priceFormat(post.gia),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Text(
                                    post.tenXa,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text(
                                post.diemBaiDang.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildListItem(int position) {
  //   return ListTile(
  //     dense: true,
  //     leading: Icon(Icons.cloud_circle),
  //     title: Text(
  //       '${_postStore.postList.posts[position].tieuDe}',
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //       softWrap: false,
  //       style: Theme.of(context).textTheme.title,
  //     ),
  //     subtitle: Text(
  //       '${_postStore.postList.posts[position].moTa}',
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //       softWrap: false,
  //     ),
  //   );
  // }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(_postStore.errorStore.errorMessage,context);
        }

        return SizedBox.shrink();
      },
    );
  }

  void _showBottomSheet() async {
    _postStore.filter_model = await showModalBottomSheet<filter_Model>(
        context: context,
        enableDrag: false,
        isDismissible: false,
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchController.dispose();
    super.dispose();
  }
}
