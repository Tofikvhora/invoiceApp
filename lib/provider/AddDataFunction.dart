import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDataProvider extends ChangeNotifier {
  List<List<String>> alldata = [];
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

  void addAllData(
      int srNO,
      TextEditingController amount,
      TextEditingController form,
      TextEditingController to,
      TextEditingController labour,
      String hold,
      TextEditingController date,
      TextEditingController vehicleNo,
      TextEditingController companyName,
      BuildContext context) {
    try {
      companyNameString = companyName.text;
      alldata.add([
        srNO.toString(),
        amount.text,
        form.text,
        to.text,
        labour.text,
        hold,
        date.text,
        vehicleNo.text,
      ]);
      // _srNo.add(srNO.text);
      // _amount.add(amount.text);
      // _from.add(form.text);
      // _to.add(to.text);
      // _hold.add(hold.text);
      // _date.add(date.text);
      // _vehicleNO.add(vehicleNo.text);
      // _labourAmount.add(labour.text);
      notifyListeners();
    } catch (e) {
    } finally {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Data Added Successfully",
            style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
      ));
      notifyListeners();
    }
    notifyListeners();
  }
}
