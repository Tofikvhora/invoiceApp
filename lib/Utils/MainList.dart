import 'package:flutter/cupertino.dart';
import 'package:newmahirroadways/Models/MainModal.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/HomePage.dart';
import 'package:newmahirroadways/View/SavedPdf/SavedMainFile/SavedMainFile.dart';
import 'package:newmahirroadways/View/TruckPages/TruckPage.dart';

class MainList {
  static List<MainModel> items(BuildContext context) {
    return <MainModel>[
      MainModel(
          name: "Invoice Generator",
          image: "asset/images/invoice.png",
          onTap: () async {
            HomePage.route.pushOnThis(context);
          }),
      MainModel(
          name: "Truck Management",
          image: "asset/images/delivery.png",
          onTap: () {
            TruckPage.route.pushOnThis(context);
          }),
      MainModel(
          name: "Party Management",
          image: "asset/images/part.png",
          onTap: () {}),
      MainModel(
          name: "Buy Sell Management",
          image: "asset/images/payment-method.png",
          onTap: () {}),
      MainModel(
          name: "Saved Invoices",
          image: "asset/images/management.png",
          onTap: () {
            SavedMainFile.route.pushOnThis(context);
          })
    ];
  }
}
