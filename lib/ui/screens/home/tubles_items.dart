import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/config/config.dart';
import 'package:tubles/core/models/tubles_model.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';
import 'package:tubles/core/viewmodels/page_provider.dart';

class TublesItems extends StatefulWidget {
  @override
  _TublesItemsState createState() => _TublesItemsState();
}

class _TublesItemsState extends State<TublesItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProv, _) {

        if (pageProv.pageController == null) {
          pageProv.initController();
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {

            return AnimatedPositioned(
              duration: Duration(seconds: 4),
              curve: Curves.elasticInOut,
              bottom: pageProv.bottomPosition,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: pageProv.pageHeight,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollUpdateNotification) {
                        pageProv.changePagePosition();
                      }
                    },
                    child: PageView.builder(
                      onPageChanged: (pos) => pageProv.changeCurrentPage(pos, context),
                      physics: BouncingScrollPhysics(),
                      controller: pageProv.pageController,
                      itemCount: mapProv.tublesList.length,
                      itemBuilder: (context, index) {
                        
                        final scale = max(pageProv.scaleFraction, (pageProv.fullScale - (index - pageProv.page).abs()) + pageProv.viewPortFraction);
                        var tubles = mapProv.tublesList[index];
                        
                        return _tublesChild(scale, tubles, index);
                      },
                    ),
                  ),
                ),
              ),
            );

          },
        );
      },
    );
  }

  Widget _tublesChild(double scale, TublesModel tubles, int index) {
    return Builder(
      builder: (context) {
        return Consumer<PageProvider>(
          builder: (context, pageProv, _) {
            return Consumer<MapProvider>(
              builder: (context, mapProv, _) {
                
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => mapProv.dialogNavigate(context, tubles),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: (pageProv.pageHeight / 2.8) * scale,
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
                            Container(
                              width: 64,
                              height: 64,
                              child: Image.asset("${Config.imageIcon}/destination.png", fit: BoxFit.cover),
                            ),

                            SizedBox(width: 10),
                            pageProv.page == index ? Expanded(
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
                            ) : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

}