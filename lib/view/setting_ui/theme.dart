import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  dividerColor: Colors.grey,
  cardColor: Colors.grey,
  iconTheme: const IconThemeData(color: Colors.white70),
  inputDecorationTheme: const InputDecorationTheme(
    suffixIconColor: Colors.white70,
    prefixIconColor: Colors.white70,
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    focusColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white70),
    headline4: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    headline5: TextStyle(color: Colors.white),
    headline6: TextStyle(
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: Color.fromARGB(135, 40, 39, 39),
      elevation: 25,
      type: BottomNavigationBarType.fixed),
  scaffoldBackgroundColor: const Color.fromARGB(137, 59, 54, 54),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: Color.fromARGB(137, 59, 54, 54),
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  primarySwatch: Colors.deepOrange,
);

ThemeData lightTheme = ThemeData(
  cardColor: Colors.white70,
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      disabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
  textTheme: const TextTheme(
    headline4: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    headline6: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 236, 232, 232),
      elevation: 25,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.grey),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  primarySwatch: Colors.deepOrange,
);
