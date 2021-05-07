import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/photoViewScreen.dart';
import 'package:boilerplate/ui/home/postDetail/build_properties.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final Post post;
  Detail({@required this.post});
  @override
  _DetailState createState() => _DetailState(post: post);
}

class _DetailState extends State<Detail> with TickerProviderStateMixin {
  final Post post;
  _DetailState({@required this.post});

  PostStore _postStore;
  ImageStore _imageStore;
  UserStore _userStore;

  AnimationController _ColorAnimationController;
  AnimationController _TextAnimationController;
  Animation _colorTween, _iconColorTween;
  Animation<Offset> _transTween;


  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(duration: Duration(seconds: 0),vsync: this);
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.amber)
        .animate(_ColorAnimationController);

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _postStore = Provider.of<PostStore>(context);
    _imageStore = Provider.of<ImageStore>(context);
    _userStore = Provider.of<UserStore>(context);
    if (!_imageStore.imageLoading){
      _imageStore.getImagesForDetail(this.post.id.toString());
    }
    if (!_userStore.loading){
      _userStore.getUserOfCurrentDetailPost(post.userId);
    }
    if (!_postStore.propertiesLoading){
      _postStore.getPostProperties(this.post.id.toString());
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
            return (_postStore.loading || _imageStore.imageLoading)
                ? CustomProgressIndicatorWidget()
                : Material(child: _buildContent());
          }
        ),
    ]);
  }

  Widget _buildContent(){
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime dateTime = dateFormat.parse(post.thoiDiemDang);
    var f = NumberFormat("###", "en_US");
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.78,
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        //physics: BouncingScrollPhysics(),

                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                  tag: _imageStore.imageList.images[0].id,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: size.height*0.3,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(_imageStore.imageList.images[0].duongDan),
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                        // child: Stack(
                                        //   children:[
                                        //     Observer(
                                        //       builder: (context) {
                                        //         return CachedNetworkImage(
                                        //           imageUrl: _imageStore.imageList.images[_imageStore.selectedIndex].duongDan,
                                        //           imageBuilder: (context, imageProvider) =>
                                        //               Container(
                                        //                 width: size.width,
                                        //                 height: size.height * 0.5,
                                        //                 decoration: BoxDecoration(
                                        //                   image: DecorationImage(
                                        //                       image: imageProvider,
                                        //                       fit: BoxFit.cover
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //           placeholder: (context, url) => CircularProgressIndicator(),
                                        //           errorWidget: (context, url, error) => Icon(Icons.error),
                                        //       );
                                        //     }
                                        //
                                        //     ),
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

                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color: Colors.amber,
                                                          size: 30,
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                  ),


                              ),
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
                              Padding(
                                padding: EdgeInsets.only(left: 24,top:12,bottom: 12),
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
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4,),
                                          Text(
                                            post.diemBaiDang.toString() +" reviews",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.only(left: 24,right: 24, bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: DefaultTextStyle(
                                        child: Text(post.tieuDe),
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 24,right: 24,bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [Icon(
                                        Icons.attach_money_outlined,
                                        color: Colors.amber,
                                        size: 30,
                                      ),
                                        SizedBox(width: 4,),
                                        Flexible(
                                          child: Text(
                                            post.gia.toString(),
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
                                        color: Colors.amber,
                                        size: 30,
                                      ),
                                        SizedBox(width: 4,),
                                        Flexible(
                                          child: Text(
                                            post.dienTich.toString(),
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
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 24,right: 24,bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.amber,
                                      size: 30,
                                    ),
                                    SizedBox(width: 4,),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          post.tenXa,
                                          style: TextStyle(
                                            color:Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding (
                                padding: EdgeInsets.only(right: 24,left: 24,bottom: 12,),
                                child:
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     buildFeature(Icons.hotel, "3 bedrooms"),
                                //     buildFeature(Icons.wc, "2 bathrooms"),
                                //     buildFeature(Icons.kitchen, "1 bedrooms"),
                                //     buildFeature(Icons.local_parking, "2 Parking"),
                                //   ],
                                // ),
                                Properties(_postStore.propertyList),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(right: 24,left: 24,bottom: 12),
                                  child: Text(
                                    "Mô tả chi tiết",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              ),

                              Padding(
                                  padding: EdgeInsets.only(right: 24,left: 24,bottom: 24),
                                  child: Html(
                                    data: post.moTa,
                                  )
                                //   post.moTa,
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.grey[500],
                                //   ),
                                // )
                              ),

                              Padding(
                                  padding: EdgeInsets.only(right: 24,left: 24,bottom: 10),
                                  child: Text(
                                    "Tag tìm kiếm",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 24,left: 24,bottom: 24),
                                child: buildTag(post.tagTimKiem),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))

                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24,right: 24,top: 10, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(Assets.front_img),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle
                                      )
                                  ),
                                  SizedBox(width: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.userName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Property Owner",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
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
                                  SizedBox(width: 16,),
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
                                        size: 20,),
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
                    ),

                  ]),
            ),

          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: _iconColorTween.value,
                                      size: 30,
                                    )
                                ),
                              )

                              // Icon(
                              //   Icons.arrow_back_ios,
                              //   color: _iconColorTween.value,
                              //   size: 24,
                              //
                              // ),

                          //     AppBar(
                          //
                          //   backgroundColor: _colorTween.value,
                          //   elevation: 0,
                          //   titleSpacing: 0.0,
                          //   title: Transform.translate(
                          //     offset: _transTween.value,
                          //     child: Text("Chi tiết bài đăng",style: TextStyle(color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 16),),
                          //   ),
                          //   iconTheme: IconThemeData(color: _iconColorTween.value),
                          //   actions: <Widget>[
                          //     IconButton(
                          //       icon: Icon(
                          //         Icons.arrow_back_ios,
                          //         color: Colors.white,
                          //         size: 24,
                          //       ),
                          //       //onPressed: Navigator.of(context).pop(),
                          //     )
                          //   ],
                          //
                          // ),
                        )

                    ),
                  ),
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    )
    );
  }

  Widget buildFeature(IconData iconData, String text)
  {
    return Column(
      children: [
        Icon(
          iconData,
          color: Colors.yellow[700],
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


  List<Widget> buildPhotos(BuildContext context, ImageList imageList) {
    List<Widget> list =[];

    for (var i=0;i<imageList.images.length;i++){
      list.add(buildPhoto(context, imageList.images[i], i));
    }
    return list;
  }

  Widget buildPhoto(BuildContext context, AppImage appImage, int index){
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: GestureDetector(
        onLongPress: (){
          print("image index $index");
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

  Widget buildTag(String filterName){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
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
    );
  }
  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_imageStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_imageStore.errorStore.errorMessage);
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
        )
          ..show(context);
      }
    });

    return SizedBox.shrink();
  }

  void _lauchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : _showErrorMessage('Không thể kết nối $_url');
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

