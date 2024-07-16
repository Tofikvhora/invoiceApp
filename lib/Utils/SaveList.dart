import 'package:flutter/cupertino.dart';
import 'package:newmahirroadways/Models/SaveModel.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/SavedPdf/SavedPdfFiles.dart';
import 'package:newmahirroadways/View/SavedPdf/TruckSave/TruckSavePage.dart';

class SaveList {
  static List items(BuildContext context) {
    return <SaveModel>[
      SaveModel(
          name: "Saved Invoices",
          onTap: () {
            SavedPdfFiles.route.pushOnThis(context);
          },
          img: "asset/images/invoice2.png"),
      SaveModel(
          name: "Saved Truck Details",
          onTap: () {
            TruckSavePage.route.pushOnThis(context);
          },
          img: "asset/images/delivery.png")
    ];
  }
}
