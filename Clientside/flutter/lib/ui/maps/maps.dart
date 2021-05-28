import 'package:boilerplate/blocs/application_bloc.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
// import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:provider/provider.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/ui/home/detail.dart';

// import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  // MapsScreen(): super();
  // final String title = "Bản đồ";
  final Post post;

  @override
  MapsScreen({@required this.post});
  _MapsScreenState createState() => _MapsScreenState(post: post);
}

class _MapsScreenState extends State<MapsScreen> {
  final Post post;
  _MapsScreenState({@required this.post});

  TextEditingController _autocompleteText= TextEditingController();

  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center;
  final Set<Marker> _markers = {};
  CameraPosition _position1;
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  GoogleMapController _controllerMap;
  // Location _location = Location();
  // Location location;
  Position _position = Position();
  Post postClickMarker;
  bool permissionEnable = false;
  Placemark placeMarkChoosen;

  PostStore _postStore;
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();
    // _checkPermission();
    // location = new Location();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _postStore = Provider.of<PostStore>(context);
    //_authTokenStore = Provider.of<AuthTokenStore>(context);
    // check to see if already called api
    if (this.post == null) {
      if (!_postStore.loading) {
        // _postStore.getPostsFromXY();
         _addMarkerButtonProcessed();
         _applicationBloc = Provider.of<ApplicationBloc>(context);
      }
    }
    else {
       _addMarkerButtonProcessed();
    }
    _setCameraPositon();
  }

  _getCurrentLocationDevice() async {

  }

  _checkPermission() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied)
    {
      LocationPermission permission = await Geolocator.requestPermission();
    }
    // print(checkPermission);
    else if (checkPermission == LocationPermission.always || checkPermission == LocationPermission.whileInUse)
    {
      bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
      // if ()
    }
  }

  _setCameraPositon() {
    if (this.post == null) {
      _position1 = CameraPosition(
        bearing: 192.833,
        target: LatLng(10.869811, 106.803725),
        tilt: 59.440,
        zoom: 11.0,
      );
      _center = LatLng(10.869811, 106.803725);
    }
    else {
      _position1 = CameraPosition(
        bearing: 192.833,
        target: LatLng(double.tryParse(this.post.toaDoX), double.tryParse(this.post.toaDoY)),
        tilt: 59.440,
        zoom: 13.0,
      );
      _center = LatLng(double.tryParse(this.post.toaDoX), double.tryParse(this.post.toaDoY));
    }
  }

  // static final CameraPosition _position1 = this.post == null ? CameraPosition(
  //   bearing: 192.833,
  //   target: LatLng(10.869811, 106.803725),
  //   tilt: 59.440,
  //   zoom: 11.0,
  // ) : CameraPosition(
  //   bearing: 192.833,
  //   target: LatLng(10.869811, 106.803725),
  //   tilt: 59.440,
  //   zoom: 11.0,
  // );

  Future<void> _goToCurrentLocationDevice() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    // controller.animateCamera(CameraUpdate.newLatLngZoom(13.0));
  }

  Future<void> _searchPlacemarkFromCoordinates(String value) async {
    await this._applicationBloc.searchPlaces(value);
  }

  Future<void> _goToCurrentLocationSearch() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      // _markers.removeAll(_markers);
      _markers.clear();
      _markers.add(
          Marker(
            markerId: MarkerId(this.placeMarkChoosen.postalCode),
            // position: LatLng(_applicationBloc.latTit, _applicationBloc.longTit),
            // infoWindow: InfoWindow(
            //   title: (this.placeMarkChoosen.street == null || this.placeMarkChoosen.street.isEmpty) ? '${this.placeMarkChoosen.country}' :'${this.placeMarkChoosen.street}',
            //   snippet: '${this.placeMarkChoosen.country}',
            // ),
            // onTap: () {
            //
            // },
            icon: BitmapDescriptor.defaultMarker,
          ));
      // controller.showMarkerInfoWindow(markerId)
      CameraPosition searchLocation = CameraPosition(
        bearing: 192.833,
        target: LatLng(_applicationBloc.latTit, _applicationBloc.longTit),
        tilt: 59.440,
        zoom: 16.0,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(searchLocation));
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    // _controller = controller;
    // _location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
    //     ),
    //   );
    // });
  }

  _onCameraMove(CameraPosition position) {
    setState(() {
      _lastMapPosition = position.target;
    });
  }

  _onMapTypeButtonProcessed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _getUserLocation() async {
    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled)
    {
      _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
  }

  _addMarkerButtonProcessed() {
    setState(() {
      if (this.post == null) {
        if (_postStore.postList != null)
        {
          for (int i = 0; i < _postStore.postList.posts.length; i++) {
            var postOrder =  _postStore.postList.posts[i];
            LatLng _locationPost = LatLng(double.tryParse(postOrder.toaDoX), double.tryParse(postOrder.toaDoY));
            _markers.add(Marker(
              markerId: MarkerId(postOrder.id.toString()),
              position: _locationPost,
              infoWindow: InfoWindow(
                title: '${postOrder.tagLoaiBaidang}',
                snippet: 'Số tiền',
              ),
              onTap: () {
                this.postClickMarker = postOrder;
              },
              icon: BitmapDescriptor.defaultMarker,
            ));
          }
        }
      }
      else {
        LatLng _locationPost = LatLng(double.tryParse(this.post.toaDoX), double.tryParse(this.post.toaDoY));
        _markers.add(Marker(
          markerId: MarkerId(this.post.id.toString()),
          position: _locationPost,
          infoWindow: InfoWindow(
            title: '${this.post.tagLoaiBaidang}',
            snippet: 'Số tiền',
          ),
          onTap: () {
            // this.postClickMarker = postOrder;
          },
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.amber,
      child: Icon(
        icon,
        size: 36.0,
        color: Colors.white,
      ),
    );
  }

  Widget containerBaseInfor() {
    if (this.postClickMarker != null) {
      return GestureDetector(
        child: Row(
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width/3.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    //image: NetworkImage("https://i.ibb.co/86vSMN3/download-2.jpg"),
                    image: this.postClickMarker.featuredImage!=null ? NetworkImage(this.postClickMarker.featuredImage) : AssetImage(Assets.front_img),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              height: 120,
              width: MediaQuery.of(context).size.width/2.3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${this.postClickMarker.dienTich}" + " m2",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        // "${this.postClickMarker.gia}"
                        "22 tỷ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        // color: Colors.yellow,
                        width: MediaQuery.of(context).size.width/2.8,
                        child:  Text(
                          "${this.postClickMarker.tieuDe}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container (
                        // padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width/2.8,
                        child: new Column (
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text (
                                "${this.postClickMarker.moTa}"
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>Detail(post: this.postClickMarker)));
        },
      );
    }
    else return Container();
  }

  @override
  Widget build(BuildContext context) {
    if (this.post == null) {
      return Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text(
            "Bản đồ",
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.amber,
          // actions: [
          //   IconButton(
          //     padding: EdgeInsets.only(right: 10),
          //     icon: Icon(
          //       Icons.refresh,
          //       color: Colors.white,
          //       size: 28,
          //     ),
          //     onPressed: () {
          //       setState(() {});
          //     },
          //   ),
          // ],
        ),
        body:
        // (applicationBloc.currentLocation == null) ? Center(
        //   child: CircularProgressIndicator(),
        // )
        // :
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _autocompleteText,
                decoration: InputDecoration(
                  hintText: "Nhập kinh độ và vĩ độ",
                  suffixIcon: Icon(Icons.search)
                ),

                // onChanged: (value) => this._applicationBloc.searchPlaces(value),
                onSubmitted: (value) => {
                  _searchPlacemarkFromCoordinates(value),
                  // _goToCurrentLocationDevice(),
                  _showSimpleModalDialog(context),
                },
              ),
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: Stack(
                    children: [
                      GoogleMap(
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer())),
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          // target: LatLng(applicationBloc.currentLocation.latitude, applicationBloc.currentLocation.longitude),
                          target: _center,
                          zoom: 11.0,
                        ),
                        mapType: _currentMapType,
                        markers: _markers,
                        onCameraMove: _onCameraMove,
                      ),
                      // _addMarkerButtonProcessed(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              button(_onMapTypeButtonProcessed, Icons.map),
                              SizedBox(
                                height: 16.0,
                              ),
                              // button(_onAddMarkerButtonProcessed, Icons.add_location),
                              // SizedBox(
                              //   height: 16.0,
                              // ),
                              button(_goToCurrentLocationDevice, Icons.my_location),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        // height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            children: <Widget>[
                              containerBaseInfor(),
                              // button(_onMapTypeButtonProcessed, Icons.map),
                              // SizedBox(
                              //   height: 16.0,
                              // ),
                              // button(_onAddMarkerButtonProcessed, Icons.add_location),
                              // SizedBox(
                              //   height: 16.0,
                              // ),
                              // button(_goToCurrentLocationDevice, Icons.my_location),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // (_autocompleteText == null || _autocompleteText.toString().isEmpty) ? Container()
                //     : Container(
                //   height: MediaQuery.of(context).size.height*0.8,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.black.withOpacity(.6),
                //     backgroundBlendMode: BlendMode.darken
                //   ),
                // ),
                // applicationBloc.searchResults == null ? Container()
                //     : Container(
                //   height: MediaQuery.of(context).size.height*0.8,
                //   child: ListView.builder(
                //     itemCount: applicationBloc.searchResults.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(applicationBloc.searchResults[index].description,
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),)
                //       );
                //     },
                //   ),
                // ),
              ],
            ),

          ],
        ),
      );
    }
    else {
      return Scaffold(
        primary: true,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              gestureRecognizers: Set()
                ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            // _addMarkerButtonProcessed(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    // button(_onAddMarkerButtonProcessed, Icons.add_location),
                    // SizedBox(
                    //   height: 16.0,
                    // ),
                    button(_goToCurrentLocationDevice, Icons.my_location),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  _showSimpleModalDialog(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(12.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.5,),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 18,top: 12, bottom: 16),
              child: _applicationBloc.getSuccess ? Container(
                child: ListView.separated(
                  itemCount: _applicationBloc.placemarks.length,
                  separatorBuilder: (context, position) {
                    return Divider();
                  },
                  itemBuilder: (context, position) {
                    return _buildListItem(_applicationBloc.placemarks[position], context);
                  },
                ),
              ) : Container(
                child: Column(
                  children: [
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.warning_rounded,
                      size: MediaQuery.of(context).size.width*0.2,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10,),
                    (_applicationBloc.latTit == null || _applicationBloc.longTit == null) ?
                        Column(
                          children: [
                            Text(
                              "Google Maps không tìm thấy ${_applicationBloc.inputSearch}",
                              style: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Hãy đảm bảo rằng tìm kiếm của bạn đúng định dạng: (vĩ độ, kinh độ)",
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )
                        : Text(
                      "Google Maps không tìm thấy địa chỉ từ tọa độ " + "${_applicationBloc.latTit}, ${_applicationBloc.longTit}",
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        );
      });
  }

  Widget _buildListItem(Placemark placemark, context) {
    print(placemark);
    // return Container();
    return ListTile(
      title: Text(
        (placemark.street == null || placemark.street == "Unnamed Road") ? ((placemark.subAdministrativeArea == null || placemark.subAdministrativeArea.isEmpty) ? ((placemark.administrativeArea == null || placemark.administrativeArea.isEmpty) ? placemark.country : placemark.administrativeArea) : placemark.subAdministrativeArea) : placemark.street,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: (placemark.subAdministrativeArea == null || placemark.subAdministrativeArea.isEmpty) ? (placemark.administrativeArea == null || placemark.administrativeArea.isEmpty) ? Text(placemark.country) : Text(placemark.administrativeArea + ", " + placemark.country)
      : Text(placemark.subAdministrativeArea + ", " + placemark.administrativeArea + ", " + placemark.country),
      onTap: (){
        _clickPlaceMark(placemark, context);
      },
    );
  }

  _clickPlaceMark(Placemark placemarkGoTo, context) {
    this.placeMarkChoosen = placemarkGoTo;
    Navigator.of(context).pop();
    _goToCurrentLocationSearch();
  }
}