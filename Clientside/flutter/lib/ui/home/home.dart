import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
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
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController= ScrollController(keepScrollOffset: true);
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
      //_postStore.isIntialLoading=false;
    }
    if (!userStore.loading) {
      userStore.getCurrentUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),);
  }

  Widget buildFilter(String filterName){
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
          )
      ),
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
    return Stack(
      children: <Widget>[
      _handleErrorMessage(),
      _buildMainContent(),
      ]
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _postStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildPostsList());
      },
    );
  }
  Widget _buildPostsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 48,left: 24,right: 24, bottom: 16),
          child: TextField(
              controller: _searchController,
              onChanged: (value){
                _postStore.setSearchContent(_searchController.text);
              },
              style: TextStyle(
                fontSize: 28,
                height: 1,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  hintText: "Tìm kiếm",
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
                  border:  UnderlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black)
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                        size: 28,
                      ),
                      onPressed: (){
                        _postStore.searchPosts();
                      },
                    ),

                  )
              ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container(
                height: 32,
                child: Stack(
                  children: [
                    ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 24,),
                        buildFilter('Loại nhà'),
                        buildFilter('Giá'),
                        buildFilter('Phòng ngủ'),
                        buildFilter('Hồ bơi'),
                        SizedBox(width: 8,),
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
                                stops: [0.0,0.1],
                                colors: [
                                  Theme.of(context).scaffoldBackgroundColor,
                                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                                ]
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),),
              GestureDetector(
                onTap: (){
                  _showBottomSheet();
                },
                child: Padding(padding: EdgeInsets.only(left:16,right:24),
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
        SizedBox(height: 6,),
        Expanded(child: _buildListView()),
      ],
    );
  }
  Widget _buildListView() {



    return _postStore.postList != null
      ? SmartRefresher(
        key: _refresherKey,
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
          idleIcon:SizedBox(
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
          completeDuration: Duration(milliseconds: 500),
        ),
        onLoading: () async {
          print("loading");

          _postStore.getPosts(true);
          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) {
            setState(() {

            });
          }
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );

          _refreshController.loadComplete();

          print("111111111");
        },
        onRefresh: () async {
          print("refresh");
          _postStore.getPosts(false);

          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) setState(() {});
          isRefreshing = true;
          _refreshController.refreshCompleted();
        },
        scrollController: _scrollController,
        primary: false,
        child: ListView.builder(
          key: _contentKey,
          controller: _scrollController,
          itemCount: _postStore.postList.posts.length,
          // separatorBuilder: (context, position) {
          //   return Divider();
          // },
          itemBuilder: (context, position) {

            return _buildPostPoster(_postStore.postList.posts[position],position);
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



  Widget _buildPostPoster(Post post, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>Detail(post: post)));
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
                image: post.featuredImage!=null ? local_Converter.im(post.featuredImage) : AssetImage(Assets.front_img),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5,1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
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
                Expanded(
                    child: Container()
                ),
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
                    SizedBox(height: 4,),
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
                            SizedBox(width: 4,),
                            Text(
                              post.tenXa,
                              style: TextStyle(
                                color:Colors.white,
                                fontSize:  14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(width: 8,),
                            Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 4,),
                            Text(
                              post.dienTich.toString(),
                              style: TextStyle(
                                color:Colors.white,
                                fontSize:  14,
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
                            SizedBox(width: 4,),
                            Text(
                              post.diemBaiDang.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )
                          ],
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
          return _showErrorMessage(_postStore.errorStore.errorMessage);
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
            )
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        }
    );
  }
  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
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
