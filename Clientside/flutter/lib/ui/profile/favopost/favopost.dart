import 'dart:io';
import 'package:boilerplate/models/converter/local_converter.dart';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/hoadonbaidang/hoadonbaidang.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoPostScreen extends StatefulWidget {
  final int userid;
  FavoPostScreen({@required this.userid});
  @override
  _FavoPostScreenState createState() => _FavoPostScreenState(userid: userid);
}

class _FavoPostScreenState extends State<FavoPostScreen> {
  final int userid;
  _FavoPostScreenState({this.userid});
  GlobalKey _refresherKey2 = GlobalKey();
  GlobalKey _contentKey2 = GlobalKey();
  bool isRefreshing2 = false;
  RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController2 =
      ScrollController(keepScrollOffset: true);
  TextEditingController _searchController11 = new TextEditingController();

  PostStore postStore;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore = Provider.of<PostStore>(context);
    if (!postStore.loadingfavopost)
      postStore.getfavopost(userid, false,_searchController11==null?"":_searchController11.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài đăng yêu thích",),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(children: <Widget>[
      _handleErrorMessage(),
      _buildMainContent(),
    ]);
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return postStore.loadingfavopost
            ? CustomProgressIndicatorWidget()
            :  _buildPostsList();
      },
    );
  }

  Widget _buildPostsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 12),
          child: TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            controller: _searchController11,
            onChanged: (value) {},
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
                    onPressed: () async {
                      postStore.getfavopost(userid,false,_searchController11==null?"":_searchController11.text.toString());
                      await Future.delayed(Duration(milliseconds: 2000));
                      // if (mounted) setState(() {});
                      isRefreshing2 = true;
                      _refreshController2.refreshCompleted();
                    },
                  ),
                )),
          ),
        ),
        _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return postStore.favopost != null
        ? Expanded(
            child: SmartRefresher(
              key: _refresherKey2,
              controller: _refreshController2,
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
                completeDuration: Duration(milliseconds: 500),
              ),
              onLoading: () async {
                print("loading");
                postStore.getfavopost(userid,true,_searchController11==null?"":_searchController11.text.toString());
                await Future.delayed(Duration(milliseconds: 2000));
                if (mounted) {
                  setState(() {});
                }
                _scrollController2.jumpTo(
                  _scrollController2.position.maxScrollExtent,
                );
                _refreshController2.loadComplete();
              },
              onRefresh: () async {
                print("refresh");
                postStore.getfavopost(userid,false,_searchController11==null?"":_searchController11.text.toString());
                await Future.delayed(Duration(milliseconds: 2000));
                if (mounted) setState(() {});
                isRefreshing2 = true;
                _refreshController2.refreshCompleted();
              },
              scrollController: _scrollController2,
              primary: false,
              child: ListView.builder(
                key: _contentKey2,
                controller: _scrollController2,
                itemCount: postStore.favopost.posts.length,
                itemBuilder: (context, position) {
                  return _buildPostPoster(
                      postStore.favopost.posts[position], position);
                  //_buildListItem(position);
                },
              ),
            ))
        : Center(
            child: Text(
              "chưa có bài đăng yêu thích",
            ),
          );
  }

  Widget _buildPostPoster(Post post, int index) {
    Newpost newpost;
    return Observer(builder: (context) {
      return Card(
        margin: EdgeInsets.only(bottom: 24, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail(post: post)));
              if (!result) setState((){postStore.favopost.posts.removeAt(index);});
              print(result);
            },
            child: Container(
              height: 190,
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
                              color: post.tagLoaiBaidang!="Cho thuê"?Colors.yellow[700]:Colors.lightBlueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
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
                                  Text(post.diemBaiDang.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (postStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(postStore.errorStore.errorMessage,context);
        }

        return SizedBox.shrink();
      },
    );
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
