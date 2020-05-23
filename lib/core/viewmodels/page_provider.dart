import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';

class PageProvider extends ChangeNotifier {

  //------------------------//
  //   PROPERTY SECTIONS    //
  //------------------------//

  /// Pageview Controller
  PageController _pageController;
  PageController get pageController => _pageController;

  /// Page number
  double _page = 0;
  double get page => _page;

  /// Current page number
  int _currentPage = 0;
  int get currentPage => _currentPage;

  /// Pager Height
  double pageHeight = 140;

  /// Positoned location
  double _bottomPosition = -200;
  double get bottomPosition => _bottomPosition;
  
  /// Property for page view animations
  double viewPortFraction = 0.9;
  double scaleFraction = 0.7;
  double fullScale = 1.0;

  //------------------------//
  //   FUNCTION SECTIONS   //
  //------------------------//

  /// Function to initialize page controller
  void initController() async {
    _pageController = await PageController(
      initialPage: currentPage,
      viewportFraction: viewPortFraction
    );
    notifyListeners();
  }

  /// Function to change page position to controller
  void changePagePosition() async {
    _page = pageController.page;
    notifyListeners();
  }

  /// Function to change current Page Index
  void changeCurrentPage(int position, BuildContext context) {
    _currentPage = position;
    final mapProv = Provider.of<MapProvider>(context, listen: false);
    mapProv.changeCameraPosition(mapProv.tublesList[position].location);
    mapProv.setSelected(mapProv.tublesList[position]);
    notifyListeners();
  }

  /// Function to change current page location
  void navigatePageTo(int position) {
    _pageController.jumpToPage(position);
    notifyListeners();
  }

  /// Function to reset pageview
  void resetPageView() {
    _currentPage = 0;
    _page = 0;
    initController();
    notifyListeners();
  }

  /// Function to update bottom Position
  void updateBottomPosition(double position) {
    _bottomPosition = position;
    notifyListeners();
  }

}