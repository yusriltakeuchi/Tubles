import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/config/config.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';
import 'package:tubles/core/viewmodels/page_provider.dart';
import 'package:tubles/ui/constant/constant.dart';
import 'package:tubles/ui/screens/home/tubles_items.dart';
import 'package:tubles/ui/widgets/clip_triangle.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

/*
  Name: Tubles 
  Version: 1.1
  Author: Yusril Rapsanjani
  Website: leeyurani.com
  Description: Tubles is a simple applications to provide any tubles in
    in google maps and we as the user can navigate into the selected tubles location.
*/

class HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapProv = Provider.of<MapProvider>(context);
    if (mapProv.cameraPosition == null) {
      mapProv.initCamera(context);
    } else {
      Provider.of<PageProvider>(context, listen: false).updateBottomPosition(30);
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));

    return Stack(
      children: <Widget>[
        _tublesMarker(),
        _myLocation(),
        Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          color: Colors.white,
        ),
        mapProv.cameraPosition != null ? Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: GoogleMap(
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            markers: mapProv.markers,
            polylines: mapProv.polylines,
            mapType: MapType.normal,
            initialCameraPosition: mapProv.cameraPosition,
            onMapCreated: mapProv.onMapCreated,
            mapToolbarEnabled: false,
          ),
        ) : Center(
          child: CircularProgressIndicator(),
        ),

        mapProv.isNavigate == true 
          ? _navigateWidget() : Container(),

        mapProv.isNavigate == false ? TublesItems()
          : Container(),

        mapProv.isNavigate == true ? SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding( 
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: InkWell(
                onTap: () => mapProv.stopNavigate(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.keyboard_arrow_left, color: Colors.orange, size: 35),
                ),
              )
            ),
          ),
        ) : Container(),

        mapProv.cameraPosition != null ? SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: InkWell(
                onTap: () => mapProv.changeCameraPosition(mapProv.sourceLocation),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.location_on, color: Colors.orange,),
                ),
              )
            ),
          ),
        ) : SizedBox(),
      ],
    );
  }

  Widget _myLocation() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return RepaintBoundary(
          key: mapProv.myLocationKey,
          child: Container(
            width: 200,
            height: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.3)
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.white,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: Container(
                      width: 16,
                      height: 13,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                  ),
                  child: Icon(Icons.location_on, color: Colors.white, size: 25)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _tublesMarker() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return RepaintBoundary(
          key: mapProv.markerKey,
          child: Container(
            width: 200,
            height: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.3)
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      mapProv.tublesSelected != null ? mapProv.tublesSelected.title : "Null",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.white,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: Container(
                      width: 16,
                      height: 13,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                  ),
                  child: Center(
                    child: Image.asset("${Config.imageIcon}/destination.png", width: 24, height: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navigateWidget() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _distanceWidget(),
                    _arrivedButton(),
                  ],
                ),
              ),
              Container(
                width: deviceWidth(context),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 35),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.navigation, color: Colors.white, size: 40,)
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Sedang menuju tambal ban",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Perjalanan menuju ${mapProv.tublesSelected.title} sedang dalam proses",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _distanceWidget() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.directions, color: Colors.orange),
                SizedBox(width: 5),
                Text(
                  mapProv.distance,
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _arrivedButton() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return InkWell(
          onTap: () => mapProv.dialogCheckin(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Sampai",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
