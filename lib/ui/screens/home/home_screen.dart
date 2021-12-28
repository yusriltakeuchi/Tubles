import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';
import 'package:tubles/core/viewmodels/page_provider.dart';
import 'package:tubles/ui/constant/constant.dart';
import 'package:tubles/ui/screens/home/items/marker_item.dart';
import 'package:tubles/ui/screens/home/items/navigation_item.dart';
import 'package:tubles/ui/screens/home/items/search_item.dart';
import 'package:tubles/ui/screens/home/items/tubles_items.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// This is a function to initialize map view
    final mapProv = Provider.of<MapProvider>(context);
    final pageProv = Provider.of<PageProvider>(context, listen: false);
    if (mapProv.cameraPosition == null) {
      mapProv.initCamera(context);
    } else {
      //When map already loaded then show the item
      if ( pageProv.bottomPosition == -200)  {
        pageProv.updateBottomPosition(30);
      }
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));

    return Stack(
      children: <Widget>[
        MarkerItem.instance.tublesMarker(),
        MarkerItem.instance.myLocationMarker(),
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
            initialCameraPosition: mapProv.cameraPosition!,
            onMapCreated: mapProv.onMapCreated,
            mapToolbarEnabled: false,
          ),
        ) : Center(
          child: CircularProgressIndicator(),
        ),

        mapProv.isNavigate == true 
          ? NavigationItem() : SizedBox(),

        mapProv.isNavigate == false ? TublesItems()
          : SizedBox(),

        SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              mapProv.isNavigate == true ? _backWidget() : SizedBox(),
              mapProv.isNavigate == false 
                ? Expanded(child: SearchItem()) 
                : Expanded(child: SizedBox(width: double.infinity,)),
              mapProv.cameraPosition != null ? _myLocationWidget() : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }


  Widget _backWidget() {
    return Builder(
      builder: (context) {
        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {
            return Padding( 
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
            );
          },
        );
      }
    );
  }

  Widget _myLocationWidget() {
    return Builder(
      builder: (context) {
        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {
            return Padding(
            padding: const EdgeInsets.only(top: 30, right: 20),
            child: InkWell(
              onTap: () => mapProv.changeCameraPosition(mapProv.sourceLocation!),
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
            );
          },
        );
      }
    );
  }  
}
