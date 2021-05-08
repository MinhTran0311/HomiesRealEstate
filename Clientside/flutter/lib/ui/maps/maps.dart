import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
// import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  // MapsScreen(): super();
  // final String title = "Bản đồ";

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(10.869811, 106.803725);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  // GoogleMapController _controller;
  // Location _location = Location();
  // Location location;
  Position _position = Position();
  bool permissionEnable = false;

  PostStore _postStore;

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
    if (!_postStore.loading) {
      _postStore.getPosts();
      _addMarkerButtonProcessed();
    }
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

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(10.869811, 106.803725),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToCurrentLocationDevice() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
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
              snippet: '100 tỷ',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ));
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Bản đồ",
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
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
        ],
      ),
    );
  }
}