import 'dart:convert';
import 'dart:typed_data';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/di/permissions/permission.dart';
import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/photoViewScreen.dart';
import 'package:boilerplate/ui/home/postDetail/build_properties.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';

class Detail extends StatefulWidget {
  final Post post;
  Detail({@required this.post});
  @override
  _DetailState createState() => _DetailState(post: post);
}

class _DetailState extends State<Detail> with TickerProviderStateMixin {
  final Post post;
  _DetailState({@required this.post});
  bool finishload = false;
  PostStore _postStore;
  ImageStore _imageStore;
  UserStore _userStore;
  ThemeStore _themeStore;

  AnimationController _ColorAnimationController;
  AnimationController _TextAnimationController;
  Animation _colorTween, _iconColorTween;
  Animation<Offset> _transTween;
  Size size;

  @override
  void initState() {
    super.initState();
    _ColorAnimationController =
        AnimationController(duration: Duration(seconds: 0),vsync: this);
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.amber)
        .animate(_ColorAnimationController);

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    _postStore = Provider.of<PostStore>(context);
    _imageStore = Provider.of<ImageStore>(context);
    _userStore = Provider.of<UserStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    if (!_imageStore.imageLoading && !finishload){
      _imageStore.getImagesForDetail(this.post.id.toString());
    }
    if (!finishload){
      _postStore.addViewForPost(post.id);
    }
    if (!_userStore.loadingUserPostDetail && !finishload){
      _userStore.getUserOfCurrentDetailPost(post.userId);
    }
    if (!_postStore.propertiesLoading && !finishload){
      _postStore.getPostProperties(this.post.id.toString());
    }
    if(!_postStore.getRecommendPostsFutureLoading && !finishload) {
      _postStore.getRecommendPosts(post.tagTimKiem,false);
    }
    if (Preferences.access_token.isNotEmpty && !_postStore.isBaiGhimYeuThichLoading && !finishload)
    {
      _postStore.isBaiGhimYeuThichOrNot(this.post.id.toString());
      finishload=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        Observer(
          builder: (context)
          {
            return (_postStore.loading || _imageStore.imageLoading || _postStore.getRecommendPostsFutureLoading || _userStore.loadingUserPostDetail || (Preferences.access_token.isNotEmpty && _postStore.isBaiGhimYeuThichLoading) || _postStore.propertiesLoading)
                ? CustomProgressIndicatorWidget()
                :  _buildContent();
          }
        ),
    ]);
  }

  Widget _buildContent(){
    size = MediaQuery.of(context).size;
    //Uint8List bytes = base64Decode(_userStore.user.profilePicture);
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                ),
                child: buildContent(size),
              ),
            ),
            buildReturnButton(),
            Observer(
              builder: (context) {
                if (_postStore.createOrChangeSuccess && _postStore.isBaiGhimYeuThich){
                    showSuccssfullMesssage("Đã thêm bài đăng vào danh sách yêu thích",context);
                    return Container(width: 0, height: 0);
                }
                else if (_postStore.createOrChangeSuccess && !_postStore.isBaiGhimYeuThich) {
                  showSuccssfullMesssage("Đã xóa bài đăng khỏi danh sách yêu thích",context);
                  return Container(width: 0, height: 0);
                }
                 else {
                  return showErrorMessage(_postStore.errorStore.errorMessage,context);
                }
              },
            ),
          ],
        ),
      )
      ),
    );
  }

  Widget buildContent(Size size){
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildMainContent(size),
          buildOwnerInfo(),
      ]);
  }
  Widget buildMainContent(Size size){
    return Flexible(
      flex: 7,
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBackGround(size),
              Container(
                height: 100,
                child: Padding(
                    padding: EdgeInsets.only(left:12, bottom:6,top: 12,right: 12),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: buildPhotos(context, _imageStore.imageList),
                    )
                ),
              ),
              buildDateAndScore(),
              buildTieuDe(),
              buildSquareAndPrice(),
              buildDiaChi(size),
              Padding(
                padding: EdgeInsets.only(right: 24,left: 24,bottom: 12,),
                child:_postStore.propertyList!=null? Properties(_postStore.propertyList):Container(width: 0,height: 0,),
              ),
              buildHeadline("Mô tả chi tiết"),
              Padding(
                  padding: EdgeInsets.only(right: 24,left: 24,bottom: 24),
                  child: Html(
                    data: post.moTa,
                  )
              ),
              buildMap(),
              buildHeadline("Tag tìm kiếm"),
              Padding(
                padding: EdgeInsets.only(right: 24,left: 24,bottom: 24),
                child: buildTagList(post.tagTimKiem),
              ),
              //(_postStore.rcmPostList !=null && _postStore.rcmPostList.posts.length>1) ? buildRcmPost() :Container(width: 0,height:0,) ,
              buildRcmPost(),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildReturnButton(){
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  child: AnimatedBuilder(
                      animation: _ColorAnimationController,
                      builder: (context,child) =>
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: _colorTween.value,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: _iconColorTween.value,
                                  size: 30,
                                )
                            ),
                          )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeadline(String str){
    return Padding(
        padding: EdgeInsets.only(right: 24,left: 24,bottom: 12),
        child: Text(
          str,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }

  Widget buildBackGround(Size size){
    return Stack(
        children: [
          Observer(
              builder: (context){
                return Container(
                  height: size.height*0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_imageStore.imageList.images[_imageStore.selectedIndex].duongDan),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ]
                        )
                    ),
                  ),
                );}
          ),
          Container(
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24,right: 24, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Center(
                          child: Text(
                            post.tagLoaiBaidang,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Preferences.access_token.isNotEmpty ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Observer(
                                builder: (context){
                                  return (_postStore.isBaiGhimYeuThich) ? Icon(Icons.favorite, color: Colors.amber, size: 30,)
                                      : Icon(Icons.favorite_border_outlined, color: Colors.amber, size: 30,);}
                            ),
                            onPressed: () {
                              _postStore.createOrChangeStatusBaiGhimYeuThich(post.id.toString());
                            },
                          ),
                        ),
                      ):Container(width: 0, height: 0,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
    );
  }

  Widget buildDateAndScore(){
    return Padding(
      padding: EdgeInsets.only(left: 24, top:12, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            post.thoiDiemDang.substring(8,10)+"/"+ post.thoiDiemDang.substring(5,7)+"/"+post.thoiDiemDang.substring(0,4),
            style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                Text(
                  post.diemBaiDang.toString().split(".")[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 4,),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildTieuDe(){
    return Padding(
      padding: EdgeInsets.only(left: 24,right: 24, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: DefaultTextStyle(
              child: SelectableText(post.tieuDe),
              style: TextStyle(
                color: _themeStore.darkMode? Colors.white : Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPhoto(BuildContext context, AppImage appImage, int index){
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: GestureDetector(
        onTap: (){_imageStore.selectedIndex=index;},
        onLongPress: (){
          _imageStore.selectedIndex=index;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PhotoViewScreen(imageList: _imageStore.imageList.images, index: index)));
        },

        child: Container(
          margin: EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
              image: NetworkImage(appImage.duongDan),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSquareAndPrice(){
    return Padding(
      padding: EdgeInsets.only(left: 24,right: 24,bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money_outlined,),
              SizedBox(width: 4,),
              Flexible(
                child: Text(
                  priceFormat(post.gia),
                  style: TextStyle(
                    color:Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.zoom_out_map,
              ),
              SizedBox(width: 4,),
              Flexible(
                child: Text(
                  post.dienTich.toString() + ' m2',
                  style: TextStyle(
                    color:Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),],
          )
        ],
      ),
    );
  }
  Widget buildDiaChi(Size size){
    return Padding(
      padding: EdgeInsets.only(left: 24,right: 24,bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
          ),
          SizedBox(width: 4,),
          Container(
              width: size.width-24-58,
              height: 24,
              child: Marquee(
                text:post.diaChi.isEmpty ? "" : post.diaChi +', '+ post.tenXa+
                    (post.tenHuyen.isEmpty?"":", " + post.tenHuyen) + (post.tenTinh.isEmpty?"":", " + post.tenTinh),
                style: TextStyle(
                  color:Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                crossAxisAlignment: CrossAxisAlignment.start,
                scrollAxis: Axis.horizontal,
                pauseAfterRound: Duration(seconds: 1),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeEndFraction: 0.1,
                numberOfRounds: null,
                velocity: 60.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                //decelerationDuration: Duration(milliseconds: 500),
                //decelerationCurve: Curves.easeOut,
                blankSpace: 20.0,
              )
          ),
        ],
      ),
    );
  }
  Widget buildMap(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeadline("Bản đồ"),
        Padding(
            padding: EdgeInsets.only(right: 24,left: 24,bottom: 24),
            child: Container(
              height: 350,
              child: MapsScreen(post: this.post),
            )
        )
      ],
    );
  }
  Widget buildRcmPost(){
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeadline("Bài viết cùng chủ đề"),
            Container(height: 200,
              child: Padding(
                  padding: EdgeInsets.only(left:12, bottom:6,top: 12,right: 12),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: buildRecommendPosts(context),
                  )
              ),
            )
          ],
        )
    );
  }

  List<Widget> buildPhotos(BuildContext context, ImageList imageList) {
    List<Widget> list =[];

    for (var i=0;i<imageList.images.length;i++){
      list.add(buildPhoto(context, imageList.images[i], i));
    }
    return list;
  }
  Widget buildFeature(IconData iconData, String text){
    return Column(
      children: [
        Icon(
          iconData,
          size:28,
        ),
        SizedBox(height: 8,),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget buildTagList(String tags){
    List<Widget> list=[];
    var splittedTags = tags.split(",");
    for (int i=0;i<splittedTags.length;i++){
      list.add(buildTag(splittedTags[i]));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 15,
      children: list,
    );
  }
  Widget buildTag(String filterName){
    return GestureDetector(
      onTap: (){
        //_postStore.setSearchContent(post.tagTimKiem);
        _postStore.setTagFilterModel(filterName);
        _postStore.getRecommendPosts(filterName,true);
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
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
        child: FittedBox(
          fit: BoxFit.contain,
          child:Text(
            filterName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> buildRecommendPosts(BuildContext context){
    List<Widget> list =[];
    for (int i=0; i<_postStore.rcmPostList.posts.length; i++){
      //if (_postStore.rcmPostList.posts[i].id!=post.id)

        list.add(buildRecommendPost(context,_postStore.rcmPostList.posts[i],i));
    }
    return list;
  }
  Widget buildRecommendPost(BuildContext context, Post post, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(11),
          color: _themeStore.darkMode ? Color.fromRGBO(30, 32, 38, 1) :  Colors.grey[50],
        ),
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detail(post: post)));
            },
            child: Container(

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(post.featuredImage),
                            fit: BoxFit.cover,
                          ),
                        ),),
                    ),
                    Expanded(
                      flex:1,
                      child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      priceFormat(post.gia),
                                      style: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      post.dienTich.toString() +' m2',
                                      style: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                                child: SelectableText(
                                  post.tieuDe,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _themeStore.darkMode ? Colors.white : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                                  child: Container(
                                    width: 130,
                                    height: 16,
                                    child: Marquee(
                                      text:post.diaChi.isEmpty ? "" : post.diaChi +', '+ post.tenXa+
                                          (post.tenHuyen.isEmpty?"":", " + post.tenHuyen) + (post.tenTinh.isEmpty?"":", " + post.tenTinh),
                                      style: TextStyle(
                                        color:Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      scrollAxis: Axis.horizontal,
                                      pauseAfterRound: Duration(seconds: 1),
                                      showFadingOnlyWhenScrolling: true,
                                      fadingEdgeEndFraction: 0.1,
                                      numberOfRounds: null,
                                      velocity: 40.0,
                                      accelerationDuration: Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      //decelerationDuration: Duration(milliseconds: 500),
                                      //decelerationCurve: Curves.easeOut,
                                      blankSpace: 20.0,
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget buildOwnerInfo(){
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            color: _themeStore.darkMode ? AppColors.darkBlueForCardDarkTheme:AppColors.greyForCardLightTheme,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24,right: 24,top: 10, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Observer(
                    builder: (context) {
                      return Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   //image: _userStore.user.profilePicture.isNotEmpty ? Image.memory(bytes) : AssetImage(Assets.front_img),
                            //   image: _userStore.userOfCurrentPost.profilePicture.isNotEmpty ? imageFromBase64String(_userStore.user.profilePicture): AssetImage(Assets.front_img),
                            //   fit: BoxFit.cover,
                            // ),
                            shape: BoxShape.circle
                        ),
                        child: (_userStore.userOfCurrentPost==null || _userStore.userOfCurrentPost.profilePicture == null || _userStore.userOfCurrentPost.profilePicture.isEmpty) ? CircleAvatar(
                          backgroundColor: Colors.amber.shade800,
                          child: Text((
                              _userStore.userOfCurrentPost.name.substring(0,1) +  _userStore.userOfCurrentPost.surname.substring(0,1)).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                            : CircleAvatar(
                          child: ClipOval(child: imageFromBase64String(_userStore.userOfCurrentPost.profilePicture)),
                          backgroundColor: Colors.brown.shade800,
                        ),
                      );
                    }
                  ),
                  SizedBox(width: 12,),
                  Container(
                    width: size.width*0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(post.userName + "121 12 12 12 12",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: _themeStore.darkMode ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SelectableText(
                          _userStore.userOfCurrentPost.phoneNumber ?? _userStore.userOfCurrentPost.emailAddress,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone,
                        color: Colors.amber,
                        size: 20,),
                      onPressed: (){
                        _lauchURL("tel:"+_userStore.user.phoneNumber);
                      },
                    ),
                  ),
                  SizedBox(width: 6,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.message,
                        color: Colors.amber,
                        size: 20,
                      ),
                      onPressed: (){
                        _lauchURL("sms:"+_userStore.user.phoneNumber);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Image imageFromBase64String(String base64String) {
    Uint8List bytes = base64.decode(base64String);
    return Image.memory(bytes);
  }


  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_imageStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(_imageStore.errorStore.errorMessage,context);
        }
        return SizedBox.shrink();
      },
    );
  }


  void _lauchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : showErrorMessage('Không thể kết nối $_url',context);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 100);

      // _TextAnimationController.animateTo(
      //     (scrollInfo.metrics.pixels - 350) / 50);
      return true;
    }
  }

}

