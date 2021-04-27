import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Detail extends StatelessWidget {
  final Post post;
  Detail({@required this.post});
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: Assets.front_img,
              child: Container(
                height: size.height*0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.front_img),
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
              )
          ),
          Container(
            height: size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
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
                Expanded(child: Container()),

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

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.6 * 0.8,
                    child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: BouncingScrollPhysics(),

                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hinh anh
                          // Container(
                          //     height: 100,
                          //     child: Padding(
                          //       padding: EdgeInsets.only(bottom:24),
                          //       child: ListView(
                          //         physics: BouncingScrollPhysics(),
                          //         scrollDirection: Axis.horizontal,
                          //         shrinkWrap: true,
                          //         children: buildPhotos(property.images),
                          //       ),
                          //     )
                          // )
                          Padding(
                            padding: EdgeInsets.only(left: 24,top:12,bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(post.thoiDiemDang,
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
                                    maxLines: 2,
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
                                Icon(
                                  Icons.location_on,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(width: 4,),
                                Expanded(
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
                            padding: EdgeInsets.only(right: 24,left: 24,bottom: 24,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildFeature(Icons.hotel, "3 bedrooms"),
                                buildFeature(Icons.wc, "2 bathrooms"),
                                buildFeature(Icons.kitchen, "1 bedrooms"),
                                buildFeature(Icons.local_parking, "2 Parking"),
                              ],
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(right: 24,left: 24,bottom: 10),
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
                    height: size.height * 0.6 * 0.2,
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
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.amber,
                                    size: 20,
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
                                  child: Icon(
                                    Icons.message,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                )
              ]),
            ),
          ),

        ],
      ),

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

  List<Widget> buildPhotos(List<String> images)
  {
    List<Widget> list =[];
    list.add(SizedBox(width: 24,));
    for (var i=0;i<images.length;i++){
      list.add(buildPhoto(images[i]));
    }
    return list;
  }
  Widget buildPhoto(String url){
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
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
}
