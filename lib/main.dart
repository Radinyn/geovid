import 'package:flutter/material.dart';
import 'home.dart';
import 'loading.dart';
import 'lang.dart';
import 'mode.dart';
import 'info.dart';
import 'book.dart';

void main() => runApp(MaterialApp(
  title: "Geovid",
  initialRoute: "/",
  routes: {
    "/" : (context) => Loading(),
    "/home" : (context) => Home(),
    "/home/lang" : (context) => Lang(),
    "/home/mode" : (context) => Mode(),
    "/home/info" : (context) => Info(),
    "/home/book" : (context) => Book(),
  },
));
