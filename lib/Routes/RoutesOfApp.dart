import 'package:flutter/material.dart';
import 'package:newmahirroadways/View/DieselPage.dart';
import 'package:newmahirroadways/View/HomePage.dart';

class RoutesOfApp {
  static MaterialPageRoute genRoutes(setting) {
    switch (setting.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case DieselPage.route:
        return MaterialPageRoute(builder: (_) => const DieselPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(
                    title: Text(
                      "Error",
                    ),
                    centerTitle: true)));
    }
  }
}
