
import 'package:flutter/material.dart';

import 'Page/calendar.dart';

final routes = {
  // '/': (context) => 
  '/start': (context) => CanlendarPage()
};

// MaterialApp
final onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
        return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};