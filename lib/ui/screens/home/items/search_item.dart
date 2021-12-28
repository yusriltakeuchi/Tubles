import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/config/config.dart';
import 'package:tubles/core/models/tubles_model.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';

class SearchItem extends StatefulWidget {

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  var searchController = TextEditingController();
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return _searchWidget();
  }

  Widget _searchWidget() {
    return Builder(
      builder: (context) {
        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 15, left: 15),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.text,
                      focusNode: focusNode,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600
                      ),
                      decoration: InputDecoration(
                        hintText: "Mau cari tubles apa?",
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none
                      ),
                      onChanged: (String value) => mapProv.searchTubles(value),
                    ),
                  ),
                ),

                // This is the item for search result
                mapProv.filteredTubles != null 
                  && mapProv.filteredTubles!.length > 0
                  ? _searchResultWidget()
                  : SizedBox()
              ],
            );
          },
        );
      }
    );
  }

  Widget _searchResultWidget() {
    return Builder(
      builder: (context) {
        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {
            return Container(
              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mapProv.filteredTubles!.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  var _item = mapProv.filteredTubles![index];
                  return _searchItem(_item);
                },
              )
            );
          },
        );
      },
    );
  }

  Widget _searchItem(TublesModel tubles) {
    return Builder(
      builder: (context) {

        return Consumer<MapProvider>(
          builder: (context, mapProv, _) {

            return Material(
              color: Colors.transparent,
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  focusNode.unfocus();
                  searchController.text = "";
                  mapProv.onItemSearchClick(tubles);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        child: Image.asset("${Config.imageIcon}/destination.png", fit: BoxFit.cover),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tubles.title!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              tubles.description!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54
                              ),
                              maxLines: 1,
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
        );
      },
    );
  }
}