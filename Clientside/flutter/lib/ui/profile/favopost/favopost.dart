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
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class FavoPostScreen extends StatefulWidget {
  final int userid;
  FavoPostScreen({@required  this.userid});
  @override
  _FavoPostScreenState createState() =>
      _FavoPostScreenState( userid: userid);
}

class _FavoPostScreenState extends State<FavoPostScreen> {
  final int userid;
  _FavoPostScreenState({this.userid});
  PostStore postStore;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore = Provider.of<PostStore>(context);
    if(!postStore.loadingfavopost) postStore.getfavopost(userid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Icon: Icons.app_registration,
        backgroundColor: Colors.white,
        title: Text(
          "Bài đăng yêu thích của tôi",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.amber,
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
        return postStore.loadingfavopost
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildPostsList());
      },
    );
  }

  Widget _buildPostsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return postStore.favopost != null
        ? Expanded(
            child: ListView.separated(
              itemCount: postStore.favopost.posts.length,
              separatorBuilder: (context, position) {
                return Divider();
              },
              itemBuilder: (context, position) {
                return _buildPostPoster(
                    postStore.favopost.posts[position], position);
                //_buildListItem(position);
              },
            ),
          )
        : Center(
            child: Text(
              "chưa có bài đăng yêu thích",
            ),
          );
  }
  Widget _buildPostPoster(Post post, int index) {
    Newpost newpost;
    Post post1=new Post();
    post1=post as Post;
    return Observer(
        builder: (context) {
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
                MaterialPageRoute(builder: (context) => Detail(post: post1)));
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );});
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
