import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubles/core/viewmodels/maps_provider.dart';
import 'package:tubles/core/viewmodels/page_provider.dart';
import 'package:tubles/ui/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Tubles",
        theme: ThemeData(
          fontFamily: 'Proxima-Regular',
          primaryColor: Colors.orange, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}