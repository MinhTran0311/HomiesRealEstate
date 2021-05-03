import 'package:boilerplate/models/image/image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewScreen extends StatefulWidget {
  final List<AppImage> imageList;
  final int index;
  PhotoViewScreen({@required this.imageList, @required this.index});
  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {

  @override
  initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int firstPage = widget.index;
    PageController _pageController = PageController(initialPage: firstPage);
    return Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.imageList[index].duongDan),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.imageList[index].id),
            );
          },
          itemCount: widget.imageList.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          //backgroundDecoration: Decoration(),
          pageController: _pageController,
        )
    );
  }


}
