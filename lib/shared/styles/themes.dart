import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  iconTheme: IconThemeData(
    color: Colors.black ,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0 ,
      fontWeight: FontWeight.w600 ,
      color: Colors.black ,
    ) ,
  ) ,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    actionsIconTheme: IconThemeData(
      color: Colors.black ,
    ),
    backwardsCompatibility: false,
    color: Colors.white ,
    elevation: 5.0 ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white ,
      statusBarIconBrightness: Brightness.dark ,
    ) ,
    titleTextStyle: TextStyle(
      color: Colors.black ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.bold ,
    ),
  ) ,
  primarySwatch: Colors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue ,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.blue ,
    elevation: 25.0 ,
  ),
  scaffoldBackgroundColor: Colors.white ,
);
ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0 ,
    actionsIconTheme: IconThemeData(
      color:HexColor('#444444') ,
    ),
    backwardsCompatibility: false,
    color: HexColor('#444444') ,
    elevation: 0.0 ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#444444') ,
      statusBarIconBrightness: Brightness.light ,
    ) ,
    titleTextStyle: TextStyle(
      color: Colors.white ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.bold ,
    ),
  ) ,
  iconTheme: IconThemeData(
    color: Colors.white ,
  ),
  primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange ,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.deepOrange ,
    unselectedItemColor: Colors.grey,
    elevation: 25.0 ,
    backgroundColor: HexColor('#444444') ,
  ),
  scaffoldBackgroundColor: HexColor('#444444') ,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0 ,
      fontWeight: FontWeight.w600 ,
      color: Colors.white ,
    ) ,
  ) ,
);