import 'package:boilerplate/blocs/application_bloc.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/maps/map_store.dart';
import 'package:provider/provider.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';

// import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  // MapsScreen(): super();
  // final String title = "Bản đồ";
  final Post post;
  final String type;

  @override
  MapsScreen({@required this.post, this.type});

  _MapsScreenState createState() => _MapsScreenState(post: post, type: type);
}

class _MapsScreenState extends State<MapsScreen> {
  final Post post;
  final String type;

  ThemeStore _themeStore;

  _MapsScreenState({@required this.post, this.type});

  TextEditingController _autocompleteText = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center;
  final Set<Marker> _markers = {};
  List<Marker> myMarker = [];
  final Set<Marker> _markersDangBai = {};
  CameraPosition _position1;
  LatLng _lastMapPosition = _center;
  LatLng _tapPointClick = _center;
  MapType _currentMapType = MapType.normal;
  GoogleMapController _controllerMap;

  String _darkMapStyle;
  String _lightMapStyle;

  // Location _location = Location();
  // Location location;
  Position _position = Position();
  Post postClickMarker;
  bool permissionEnable = false;
  Placemark placeMarkChoosen;

  PostStore _postStore;
  MapsStore _mapsStore;

  // Map
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    // location = new Location();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _postStore = Provider.of<PostStore>(context);
    _mapsStore = Provider.of<MapsStore>(context);
    _applicationBloc = Provider.of<ApplicationBloc>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    //_authTokenStore = Provider.of<AuthTokenStore>(context);
    // check to see if already called api
    if (this.post == null) {
      if (!_postStore.loading) {
        // _postStore.getPostsFromXY();
        if (this.type == null) _addMarkerButtonProcessed();
      }
      _mapsStore.checkPermission();
    } else {
      _addMarkerButtonProcessed();
    }
    _setCameraPositon();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    // final theme = WidgetsBinding.instance.window.platformBrightness;
    if (_themeStore.darkMode)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
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
    } else {
      _position1 = CameraPosition(
        bearing: 192.833,
        target: LatLng(double.tryParse(this.post.toaDoX),
            double.tryParse(this.post.toaDoY)),
        tilt: 59.440,
        zoom: 13.0,
      );
      _center = LatLng(
          double.tryParse(this.post.toaDoX), double.tryParse(this.post.toaDoY));
    }
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    _tapPointClick = tappedPoint;
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        onDragEnd: (dragEndPosition) {
          print(dragEndPosition);
          _tapPointClick = dragEndPosition;
        },
      ));
    });
  }

  Future<void> _goToCurrentLocationPostCurrent() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
    // controller.animateCamera(CameraUpdate.newLatLngZoom(13.0));
  }

  Future<void> _goToCurrentLocationDevice() async {
    final GoogleMapController controller = await _controller.future;
    await _mapsStore.checkPermission();
    if (_mapsStore.isLocationServiceEnabled) {
      controller.animateCamera(CameraUpdate.newCameraPosition(_mapsStore.cameraPositionCurrent));
    }
    // controller.animateCamera(CameraUpdate.newLatLngZoom(13.0));
  }

  Future<void> _searchPlacemarkFromCoordinates(String value) async {
    await this._applicationBloc.searchPlaces(value);
  }

  Future<void> _searchPlacemarkFromLatAndLong(double lat, double long) async {
    await this._applicationBloc.searchPlace(lat, long);
  }

  Future<void> _goToCurrentLocationSearch() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      // _markers.removeAll(_markers);
      if (this.type == "Đăng bài") {
        myMarker.clear();
        myMarker.add(Marker(
          markerId: MarkerId(this.placeMarkChoosen.postalCode),
          position: LatLng(_applicationBloc.latTit, _applicationBloc.longTit),
          // infoWindow: InfoWindow(
          //   title: (this.placeMarkChoosen.street == null || this.placeMarkChoosen.street.isEmpty) ? '${this.placeMarkChoosen.country}' :'${this.placeMarkChoosen.street}',
          //   snippet: '${this.placeMarkChoosen.country}',
          // ),
          // onTap: () {
          //
          // },
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
      // controller.showMarkerInfoWindow(markerId)
      CameraPosition searchLocation = CameraPosition(
        bearing: 192.833,
        target: LatLng(_applicationBloc.latTit, _applicationBloc.longTit),
        tilt: 59.440,
        zoom: 14.5,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(searchLocation));
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _setMapStyle();
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
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }

  _addMarkerButtonProcessed() {
    setState(() {
      if (this.post == null) {
        if (_postStore.postList != null) {
          for (int i = 0; i < _postStore.postList.posts.length; i++) {
            var postOrder = _postStore.postList.posts[i];
            LatLng _locationPost = LatLng(double.tryParse(postOrder.toaDoX),
                double.tryParse(postOrder.toaDoY));
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
      } else {
        LatLng _locationPost = LatLng(double.tryParse(this.post.toaDoX),
            double.tryParse(this.post.toaDoY));
        _markers.add(Marker(
          markerId: MarkerId(this.post.id.toString()),
          position: _locationPost,
          infoWindow: InfoWindow(
            title: '${this.post.tagLoaiBaidang}',
            snippet: priceFormat(this.post.gia),
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
      heroTag: null,
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
              width: MediaQuery.of(context).size.width / 3.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    //image: NetworkImage("https://i.ibb.co/86vSMN3/download-2.jpg"),
                    image: this.postClickMarker.featuredImage != null
                        ? NetworkImage(this.postClickMarker.featuredImage)
                        : AssetImage(Assets.front_img),
                    fit: BoxFit.cover,
                  )),
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
              width: MediaQuery.of(context).size.width / 2.3,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        // color: Colors.yellow,
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Text(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        // padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("${this.postClickMarker.moTa}"),
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
              MaterialPageRoute(
                  builder: (context) => Detail(post: this.postClickMarker)));
        },
      );
    } else
      return Container();
  }

  //Show when click maps
  Widget containerLatngInfor() {
    if (_tapPointClick != 0) {
      // _searchPlacemarkFromLatAndLong(_tapPointClick.latitude, _tapPointClick.longitude);
      return GestureDetector(
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Flexible(
                child: Text(
                  // _applicationBloc.placemark[0].name,
                  "Linh Trung",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Flexible(
                child: Text(
                  // _applicationBloc.placemark[0].country,
                  "Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "${_tapPointClick.latitude.toStringAsFixed(6)}, ${_tapPointClick.longitude.toStringAsFixed(6)}",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      );
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    //Map khi xem chi tiết bài đăng
    if (this.post != null) {
      return Scaffold(
        primary: true,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                    () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
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
                    button(_goToCurrentLocationPostCurrent, Icons.my_location),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    //Map khi xem bản đồ
    else if (this.type == null) {
      return Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text(
            "Bản đồ",
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Observer(
              builder: (context) {
              return Stack(
                children: [
                  GoogleMap(
                    gestureRecognizers: Set()
                      ..add(
                          Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                      ..add(Factory<ScaleGestureRecognizer>(
                              () => ScaleGestureRecognizer()))
                      ..add(
                          Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
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
                    padding: EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0, top: 96),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: <Widget>[
                          button(_onMapTypeButtonProcessed, Icons.map),
                          SizedBox(
                            height: 24.0,
                          ),
                          button(_goToCurrentLocationDevice, Icons.my_location),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    // height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: <Widget>[
                          containerBaseInfor(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        boxShadow: [
                          _themeStore.darkMode
                              ? BoxShadow()
                              : BoxShadow(
                            color: Color.fromRGBO(198, 199, 202, 1),
                            blurRadius: 10, // soften the shadow
                            spreadRadius: 0.01, //extend the shadow
                            offset: Offset(
                              8.0, // Move to right 10  horizontally
                              12.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        color: _themeStore.darkMode
                            ? Color.fromRGBO(54, 55, 58, 1)
                            : AppColors.backgroundLightThemeColor,
                      ),
                      padding: EdgeInsets.only(left: 12, top: 6),
                      child: TextField(
                        controller: _autocompleteText,
                        decoration: InputDecoration(
                          hintText: "Nhập kinh độ và vĩ độ",
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),

                        // onChanged: (value) => this._applicationBloc.searchPlaces(value),
                        onSubmitted: (value) => {
                          _searchPlacemarkFromCoordinates(value),
                          // _goToCurrentLocationDevice(),
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            setState(() {
                              _showSimpleModalDialog(context);
                            });
                          }),
                        },
                      ),
                    ),
                  ),
                ],
              );
            },)
          ],
        ),
      );
    }
    //Maps đăng bài
    else {
      return Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text(
            "Bản đồ",
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            GoogleMap(
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                    () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                // target: LatLng(applicationBloc.currentLocation.latitude, applicationBloc.currentLocation.longitude),
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: Set.from(myMarker),
              onTap: _handleTap,
              onCameraMove: _onCameraMove,
            ),
            // _addMarkerButtonProcessed(),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0, top: 96),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_onMapTypeButtonProcessed, Icons.map),
                    SizedBox(
                      height: 24.0,
                    ),
                    button(_goToCurrentLocationDevice, Icons.my_location),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              // height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: <Widget>[
                    containerBaseInfor(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  boxShadow: [
                    _themeStore.darkMode
                        ? BoxShadow()
                        : BoxShadow(
                            color: Color.fromRGBO(198, 199, 202, 1),
                            blurRadius: 10, // soften the shadow
                            spreadRadius: 0.01, //extend the shadow
                            offset: Offset(
                              8.0, // Move to right 10  horizontally
                              12.0, // Move to bottom 10 Vertically
                            ),
                          )
                  ],
                  color: _themeStore.darkMode
                      ? Color.fromRGBO(54, 55, 58, 1)
                      : AppColors.backgroundLightThemeColor,
                ),
                padding: EdgeInsets.only(left: 12, top: 6),
                child: TextField(
                  controller: _autocompleteText,
                  decoration: InputDecoration(
                    hintText: "Nhập kinh độ và vĩ độ",
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),

                  // onChanged: (value) => this._applicationBloc.searchPlaces(value),
                  onSubmitted: (value) => {
                    _searchPlacemarkFromCoordinates(value),
                    // _goToCurrentLocationDevice(),
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      setState(() {
                        _showSimpleModalDialog(context);
                      });
                    }),
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              constraints: _applicationBloc.getSuccess
                  ? BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    )
                  : BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 18, top: 12, bottom: 16),
                child: _applicationBloc.getSuccess
                    ? Container(
                        child: ListView.separated(
                          itemCount: _applicationBloc.placemarks.length,
                          separatorBuilder: (context, position) {
                            return Divider();
                          },
                          itemBuilder: (context, position) {
                            return _buildListItem(
                                _applicationBloc.placemarks[position], context);
                          },
                        ),
                      )
                    : Container(
                        child: Stack(children: [
                          Positioned(
                            right: 0.0,
                            child: GestureDetector(
                              onTap: () {
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
                          Column(
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: MediaQuery.of(context).size.width * 0.2,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (_applicationBloc.latTit == null ||
                                      _applicationBloc.longTit == null)
                                  ? Column(
                                      children: [
                                        Text(
                                          "Google Maps không tìm thấy ${_applicationBloc.inputSearch}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Hãy đảm bảo rằng tìm kiếm của bạn đúng định dạng: (vĩ độ, kinh độ)",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Google Maps không tìm thấy địa chỉ từ tọa độ " +
                                          "${_applicationBloc.latTit}, ${_applicationBloc.longTit}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                        ]),
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
        (placemark.street == null || placemark.street == "Unnamed Road")
            ? ((placemark.subAdministrativeArea == null ||
                    placemark.subAdministrativeArea.isEmpty)
                ? ((placemark.administrativeArea == null ||
                        placemark.administrativeArea.isEmpty)
                    ? placemark.country
                    : placemark.administrativeArea)
                : placemark.subAdministrativeArea)
            : placemark.street,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: (placemark.subAdministrativeArea == null ||
              placemark.subAdministrativeArea.isEmpty)
          ? (placemark.administrativeArea == null ||
                  placemark.administrativeArea.isEmpty)
              ? Text(
                  placemark.country,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              : Text(
                  placemark.administrativeArea + ", " + placemark.country,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
          : Text(
              placemark.subAdministrativeArea +
                  ", " +
                  placemark.administrativeArea +
                  ", " +
                  placemark.country,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
      onTap: () {
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
