import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';
import 'package:tubles/ui/constant/constant.dart';

class NavigationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _navigateWidget();
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
                              "Perjalanan menuju ${mapProv.tublesSelected!.title} sedang dalam proses",
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