import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

var kHeadingOne = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
var kHeadingThree = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
var kHeadingFour = const TextStyle(
    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);

const colorAccent = Color(0xff004376);
double kScreenSpan = 16;
ThemeData hrTheme = ThemeData.light().copyWith(
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: colorAccent,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: colorAccent),
    ),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorAccent)),
  ),
);
