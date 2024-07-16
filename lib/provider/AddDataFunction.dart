import 'package:flutter/material.dart';

class AddDataProvider extends ChangeNotifier {
  String companyNameString = '';
  String pdfName = '';
  int srNO = 1;
  int total = 0;
  int labourCharges = 0;
  int day = 0;
  int totalDay = 0;
  String billDate = '';

  void dayLogic(TextEditingController days) {
    day = int.parse(days.text);
    totalDay += day;
    notifyListeners();
  }

  void pdfNameFunction(
      TextEditingController name, TextEditingController dateOfBill) {
    pdfName = name.text;
    billDate = dateOfBill.text;
    notifyListeners();
  }

  void totalLabourCharges(TextEditingController labour) {
    labourCharges += int.parse(labour.text);
    notifyListeners();
  }

  void totalFunction(TextEditingController amount) {
    total += int.parse(amount.text);
    notifyListeners();
  }

  void srNOFunctions() {
    srNO++;
    notifyListeners();
  }
}
