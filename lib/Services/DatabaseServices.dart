import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/MainPage.dart';

class DatabaseServices {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> uploadUserName(TextEditingController userName,
      TextEditingController userEmail, BuildContext context) async {
    try {
      fs.collection("UserName").doc(auth.currentUser!.email.toString()).set({
        "User Name": userName.text.toString(),
        "User Email": userEmail.text.toString()
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> uploadUserData(
      BuildContext context,
      TextEditingController name,
      TextEditingController address,
      TextEditingController email,
      TextEditingController number) async {
    fs.collection("UserData").doc(auth.currentUser!.email.toString()).set({
      "CompanyName": name.text.toString(),
      "CompanyAddress": address.text.toString(),
      "CompanyEmail": email.text.toString(),
      "CompanyNumber": number.text.toString(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data Saved Successfully 🎊 ")));
      MainPage.route.pushAndReplace(context);
    });
  }

  Future<void> invoiceData(
      var srNO,
      String date,
      TextEditingController vehicleNo,
      TextEditingController form,
      TextEditingController to,
      TextEditingController feet,
      String hold,
      TextEditingController amount,
      BuildContext context) async {
    fs
        .collection("InvoiceData")
        .doc(auth.currentUser!.email.toString())
        .collection("InvoiceList")
        .doc(srNO.toString())
        .set({
      "AllData": [
        srNO,
        date.toString(),
        vehicleNo.text.toString(),
        form.text.toString(),
        to.text.toString(),
        feet.text.toString(),
        hold,
        amount.text.toString(),
      ]
    }).then((value) {
      amount.clear();
      form.clear();
      to.clear();
      feet.clear();
      date = "";
      vehicleNo.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data Added Successfully 🎊 ")));
    });
  }

  Future<void> dieselInvoice(
      int srNO,
      TextEditingController amount,
      TextEditingController liters,
      String date,
      TextEditingController vehicleNo,
      BuildContext context) async {
    fs
        .collection("InvoiceData")
        .doc(auth.currentUser!.email.toString())
        .collection("DieselInvoiceList")
        .doc(srNO.toString())
        .set({
      "AllData": [
        srNO,
        amount.text.toString(),
        liters.text.toString(),
        date,
        vehicleNo.text.toString()
      ]
    }).then((value) {
      amount.clear();
      liters.clear();
      date = "";
      vehicleNo.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invoice Data Added Successfully 🎊 ")));
    });
  }

  Future<void> saveInvoiceDiesel(
      int srNO,
      TextEditingController amount,
      TextEditingController liters,
      String date,
      TextEditingController vehicleNo,
      String invoiceName,
      BuildContext context) async {
    await fs
        .collection("SaveInvoiceDieselData")
        .doc(auth.currentUser!.email.toString())
        .collection(invoiceName.toString())
        .doc()
        .set({
      "AllData": [
        srNO,
        amount.text.toString(),
        liters.text.toString(),
        date,
        vehicleNo.text.toString()
      ]
    });
  }

  Future<void> saveInvoiceData(
      var srNO,
      String date,
      TextEditingController vehicleNo,
      TextEditingController form,
      TextEditingController to,
      TextEditingController feet,
      String hold,
      TextEditingController amount,
      TextEditingController invoiceName,
      BuildContext context) async {
    await fs
        .collection("SaveInvoiceData")
        .doc(auth.currentUser!.email.toString())
        .collection(invoiceName.text.toString())
        .doc(srNO.toString())
        .set({
      "AllData": [
        srNO,
        date.toString(),
        vehicleNo.text.toString(),
        form.text.toString(),
        to.text.toString(),
        feet.text.toString(),
        // labour.text.toString(),
        hold,
        amount.text.toString(),
      ],
    }).then((value) {});
  }

  Future<void> truckEntry(BuildContext context,
      TextEditingController truckNumber, String date, String editNumber) async {
    fs
        .collection("TruckData")
        .doc(auth.currentUser!.email.toString())
        .collection("TruckNumber")
        .doc(truckNumber.text.toString())
        .set({
      "TruckNumber": truckNumber.text.toString(),
      "OldTruckNumber": truckNumber.text.toString(),
      "Created": date,
    }).then((value) {
      truckNumber.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Truck Data Added Successfully 🎊 ")));
    });
  }

  Future<void> truckDetailsData(
      BuildContext context,
      String truckName,
      String startDate,
      String endDate,
      String garage,
      String diesel,
      String maintenance,
      String toll,
      String wheel,
      int total) async {
    fs
        .collection("TruckDetailsData")
        .doc(auth.currentUser!.email.toString())
        .collection("TruckDetailsNumber")
        .add({
      "TruckName": truckName,
      "StartDate": startDate,
      "EndDate": endDate,
      "Garage": garage,
      "Diesel": diesel,
      "Maintenance": maintenance,
      "TollTax": toll,
      "Wheel": wheel,
      "Total": total,
    }).then((value) {
      startDate = "";
      endDate = "";
      total = 0;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data Added Successfully 🎊 ")));
    });
  }
}
