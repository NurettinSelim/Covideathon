import 'package:flutter/material.dart';
import 'package:korona_app/semptom.dart';
import 'package:korona_app/settings.dart';
import 'package:korona_app/semptom2.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/semptom":
      return MaterialPageRoute(builder: (context) => Semptom());
    case "/semptom2":
      var argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => Semptom2(
                argument: argument,
              ));
    case "/settings":
      return MaterialPageRoute(builder: (context) => Settings());
  }
}
