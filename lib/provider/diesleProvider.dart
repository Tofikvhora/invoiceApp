import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DieselProvider extends ChangeNotifier {
  int srNO = 1;
  int total = 0;
  int totalLiter = 0;
  List<List<String>> alldata = [];
  void srNOFunctions() {
    srNO++;
    notifyListeners();
  }

  void totalFunction(TextEditingController amount) {
    total += int.parse(amount.text);
    notifyListeners();
  }

  void totalLiters(TextEditingController liters) {
    totalLiter += int.parse(liters.text);
    notifyListeners();
  }

  void addAllData(
      int srNO,
      TextEditingController amount,
      TextEditingController liters,
      TextEditingController date,
      TextEditingController vehicleNo,
      BuildContext context) {
    try {
      alldata.add([
        srNO.toString(),
        amount.text,
        liters.text,
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
  }
}
