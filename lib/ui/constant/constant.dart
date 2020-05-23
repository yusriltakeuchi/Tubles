import 'package:flutter/material.dart';

/// Get Device with
double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Get Device Height
double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}