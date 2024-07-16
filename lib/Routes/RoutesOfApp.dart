import 'package:flutter/material.dart';
import 'package:newmahirroadways/View/DieselPage.dart';
import 'package:newmahirroadways/View/HomePage.dart';
import 'package:newmahirroadways/View/InfoPage.dart';
import 'package:newmahirroadways/View/MainPage.dart';
import 'package:newmahirroadways/View/SavedPdf/SavedMainFile/SavedMainFile.dart';
import 'package:newmahirroadways/View/SavedPdf/SavedPdfFiles.dart';
import 'package:newmahirroadways/View/SavedPdf/TruckSave/TruckSavePage.dart';
import 'package:newmahirroadways/View/TruckPages/FindTruck.dart';
import 'package:newmahirroadways/View/TruckPages/TruckPage.dart';
import 'package:newmahirroadways/View/TruckPages/TruckfFillDetails.dart';
import 'package:newmahirroadways/View/auth/EmailVerification.dart';
import 'package:newmahirroadways/View/auth/LoginPage.dart';
import 'package:newmahirroadways/View/auth/SinginPage.dart';

class RoutesOfApp {
  static MaterialPageRoute genRoutes(settings) {
    switch (settings.name) {
      case LoginPage.route:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case HomePage.route:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case InfoPage.route:
        return MaterialPageRoute(builder: (_) => const InfoPage());
      case MainPage.route:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case SingInPage.route:
        return MaterialPageRoute(builder: (_) => const SingInPage());
      case EmailVerification.route:
        return MaterialPageRoute(builder: (_) => const EmailVerification());
      case SavedMainFile.route:
        return MaterialPageRoute(builder: (_) => const SavedMainFile());
      case TruckSavePage.route:
        return MaterialPageRoute(builder: (_) => const TruckSavePage());
      case TruckFillDetails.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              TruckFillDetails(truckNumber: settings.arguments['TruckNumber']),
        );
      case DieselPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DieselPage(pdfName: settings.arguments['data']),
        );
      case SavedPdfFiles.route:
        return MaterialPageRoute(builder: (_) => const SavedPdfFiles());
      case TruckPage.route:
        return MaterialPageRoute(builder: (_) => const TruckPage());
      case FindTruck.route:
        return MaterialPageRoute(builder: (_) => const FindTruck());
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
