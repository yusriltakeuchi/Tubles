

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tubles/core/config/config.dart';
import 'package:tubles/core/models/tubles_model.dart';
import 'package:tubles/core/services/tubles_services.dart';
import 'package:tubles/core/utils/dialog_utils.dart';

class MapProvider extends ChangeNotifier {

  //------------------------//
  //   PROPERTY SECTIONS    //
  //------------------------//
  
  //Property zoom camera
  double _cameraZoom = 16;
  double get cameraZoom => _cameraZoom;

  //Property camera position
  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;

  //Property camera tilt
  double _cameraTilt = 0;
  double get cameraTilt => _cameraTilt;

  //Property camera bearing
  double _cameraBearing = 30;
  double get cameraBearing => _cameraBearing;

  //Property my location data
  LatLng _sourceLocation;
  LatLng get sourceLocation => _sourceLocation;

  //Property tubles list
  List<TublesModel> _tublesList = TublesServices.getTubles();
  List<TublesModel> get tublesList => _tublesList;

  //Property Google Map Controller completer
  Completer<GoogleMapController> _completer = Completer();
  Completer<GoogleMapController> get completer => _completer;

  //Property Google Map Controller
  GoogleMapController _controller;
  GoogleMapController get controller => _controller;

  //Property to save all markers
  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  //Property to save all polylines
  Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  //Property to save all direction coordinate routes
  List<LatLng> _polylineCoordinates = [];
  List<LatLng> get polylineCoordinates => _polylineCoordinates;

  // which generates every polyline between start and finish
  GoogleMapPolyline _polylinePoints;
  GoogleMapPolyline get polylinePoints => _polylinePoints;

  //Your google maps API
  //Please enable this API Features:
  //- Google Maps for Android SDK
  //- Place API
  //- Directions API
  String _googleAPIKey = "<YOUR API KEY>";
  String get apiKey => _googleAPIKey;

  //Property custom icon to my location
  BitmapDescriptor _sourceIcon;
  BitmapDescriptor get sourceIcon => _sourceIcon;

  //Property custom icon to destination location
  BitmapDescriptor _destinationIcon;
  BitmapDescriptor get destinationIcon => _destinationIcon;

  //Property to handle selected tubles
  TublesModel _tublesSelected;
  TublesModel get tublesSelected => _tublesSelected;

  //Property to handle if the users navigate to tubles or not
  bool _isNavigate = false;
  bool get isNavigate => _isNavigate;

  //Property to mapStyle
  String _mapStyle;
  String get mapStyle => _mapStyle;

  //Property polylines color
  Color _polyLineColor = Colors.amber;

  //Property location services
  Location location = new Location();
  StreamSubscription<LocationData> locationSubscription;

  //------------------------//
  //   FUNCTION SECTIONS   //
  //------------------------//

  //Function to initialize camera
  void initCamera() async {
    
    //Get current locations
    await initLocation();

    //Set current location to camera
    _cameraPosition = CameraPosition(
      zoom: cameraZoom,
      bearing: cameraBearing,
      tilt: cameraTilt,
      target: sourceLocation
    );
    notifyListeners();
  }

  //Function to get current locations
  void initLocation() async {
    var locData = await location.getLocation();
    _sourceLocation = LatLng(locData.latitude, locData.longitude);
    
    notifyListeners();
  }

  //Function to listening user location changed
  void listeningLocation() {
    //Adding location listener
    locationSubscription = location.onLocationChanged().listen((LocationData data)
    {
      _sourceLocation = LatLng(data.latitude, data.longitude);
      print(data.latitude.toString());
      updateMyLocationMaker();
    });
  }

  //Function to stop listening location changed
  void stopListeningLocation() {
    locationSubscription.cancel();
  }

  //Function to change camera position
  void changeCameraPosition(LatLng location) {
    _controller.animateCamera(CameraUpdate.newLatLng(
      LatLng(location.latitude, location.longitude)
    ));

    notifyListeners();
  }

  //Function to handle when maps created
  void onMapCreated(GoogleMapController controller) async {
    
    //Loading map style
    _mapStyle = await rootBundle.loadString(Config.mapStyleFile);

    _completer.complete(controller);
    _controller = controller;

    //Set style to map
    _controller.setMapStyle(_mapStyle);
    
    await setIcons();
    setMapPins(sourceLocation, tublesList);

    notifyListeners();
  }


  //Function to set marker into my locations
  void setMyLocationMarker() {
    _markers.add(Marker(
      markerId: MarkerId("sourcePin"),
      position: sourceLocation,
      icon: _sourceIcon
    ));

    notifyListeners();
  }

  //Function to set marker into my locations
  void updateMyLocationMaker() {
    //Change camera position
    if (_controller != null) {
      changeCameraPosition(sourceLocation);
    }

    //Remove current marker
    _markers.removeWhere((m) => m.markerId.value == "sourcePin");

    //Adding new marker
    _markers.add(Marker(
      markerId: MarkerId("sourcePin"),
      position: sourceLocation,
      icon: _sourceIcon
    ));

    notifyListeners();
  }

  //Function to pin my location and tubles list
  void setMapPins(LatLng sourceLocation, List<TublesModel> destinationList) {
    //Set my location marker
    setMyLocationMarker();

    destinationList.forEach((TublesModel data) {
      _markers.add(Marker(
        markerId: MarkerId(data.title),
        position: data.location,
        icon: _destinationIcon,
        
        onTap: () => setSelected(data)
      ));
    });

    notifyListeners();
  }

  //Function to set custom icon marker
  void setIcons() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5), "${Config.imageIcon}/mylocation.png");

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5), "${Config.imageIcon}/destination.png");

    notifyListeners();
  }


  //Function to set selected tubles
  void setSelected(TublesModel data) async {
    _tublesSelected = data;

    //Remove previous polylines
    await clearPolylines();
    //Set polyline ketika klik marker
    await setPolyLines(data.location);

    notifyListeners();
  }

  //Function to create a polylines into maps
  void setPolyLines(LatLng destination) async {
    List<LatLng> result;
    try {
      _polylinePoints = GoogleMapPolyline(apiKey: apiKey);
      result = await _polylinePoints.getCoordinatesWithLocation(
        origin: sourceLocation,
        destination: destination,
        mode: RouteMode.driving
      );

    } on Exception catch(e) {
      print("ERROR GAN: " + e.toString());
    }

    if (result.isNotEmpty) {
      result.forEach((LatLng point) {
        _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude)
        );
      });
    } else {
      print("GAGAL DAPET POLYLINE");
    }

    Polyline poly = Polyline(
        polylineId: PolylineId("Polylines"),
        color: _polyLineColor,
        points: _polylineCoordinates,
        width: 5
    );

    _polylines.add(poly);
    notifyListeners();
  }


  //Function to clear all polylines
  void clearPolylines() {
    _polylines.clear();
    _polylineCoordinates.clear();
    notifyListeners();
  }

  //Function to navigate into tubles destination
  void navigate({TublesModel tubles}) async {
    if (tubles != null) {
      await setSelected(tubles);
    }

    //Removing previous marker and polylines
    _markers.clear();
    clearPolylines();

    //Adding new marker destination
    _markers.add(Marker(
      markerId: MarkerId(tublesSelected.title),
      position: tublesSelected.location,
      icon: _destinationIcon,
    ));

    //Set my location marker
    setMyLocationMarker();

    //Set polylines to marker
    setPolyLines(tublesSelected.location);
    
    //set navigate status
    _isNavigate = true;

    //Enable location listener
    listeningLocation();

    notifyListeners();
  }

  //Function to stop navigation  
  void stopNavigate() {
    _isNavigate = false;
    _markers.clear();
    clearPolylines();
    setMapPins(sourceLocation, tublesList);

    //Stop listening location
    stopListeningLocation();

    notifyListeners();
  }

  //Dialog to show if we want to go to destination or not
  void dialogNavigate(BuildContext context, TublesModel tubles) {
    DialogUtils.showDialogChoose(
      context, 
      "Navigasi Tubles", 
      "Anda yakin ingin pergi ke lokasi ini?", 
      () {
        //On Yes
        Navigator.pop(context);
        changeCameraPosition(sourceLocation);
        navigate(tubles: tubles);
      }, 
      () {
        //On No
        Navigator.pop(context);
      });
  }

  //Dialog to handle if we already in destination and want to checkin
  void dialogCheckin(BuildContext context) {
    DialogUtils.showDialogChoose(
      context, 
      "Checkin Navigasi", 
      "Anda sudah sampai ditempat tujuan?", 
      () {
        //On Yes
        Navigator.pop(context);
        changeCameraPosition(sourceLocation);
        stopNavigate();
      }, 
      () {
        //On No
        Navigator.pop(context);
      });
  }

}