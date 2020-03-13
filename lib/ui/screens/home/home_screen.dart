import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/config/config.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';

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
  Version: 1.0
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
      mapProv.initCamera();
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));
    return Stack(
      children: <Widget>[
        mapProv.cameraPosition != null ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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

        mapProv.isNavigate == true ? Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () => mapProv.dialogCheckin(context),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
          ),
        ) : Container(),

        mapProv.isNavigate == false ? TublesItem()
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
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                ),
              )
            ),
          ),
        ) : Container(),

        SafeArea(
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
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.location_on, color: Colors.white,),
                ),
              )
            ),
          ),
        ),
      ],
    );
  }
}

class TublesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapProv = Provider.of<MapProvider>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 140,
        child: ListView.builder(
          itemCount: mapProv.tublesList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {

            //init tubles
            var tubles = mapProv.tublesList[index];

            return InkWell(
              onTap: () => mapProv.dialogNavigate(context, tubles),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => mapProv.setSelected(tubles),
                        child: Container(
                          width: 64,
                          height: 64,
                          child: Image.asset("${Config.imageIcon}/destination.png", fit: BoxFit.cover),
                        ),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tubles.title,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              tubles.description,
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
            );
          },
        ),
      ),
    );
  }
}