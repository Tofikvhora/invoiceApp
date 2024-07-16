import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/View/TruckPages/TruckPdfPageOpen.dart';
import 'package:newmahirroadways/Widget/CommonButton.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:provider/provider.dart';

class TruckFillDetails extends HookWidget {
  final String truckNumber;
  static const String route = "TruckFillDetails";
  const TruckFillDetails({super.key, required this.truckNumber});

  @override
  Widget build(BuildContext context) {
    final _startDate = useTextEditingController();
    final _endDate = useTextEditingController();
    final _garage = useTextEditingController();
    final _diesel = useTextEditingController();
    final _maintenance = useTextEditingController();
    final _toll = useTextEditingController();
    final _wheel = useTextEditingController();
    final auth = FirebaseAuth.instance;
    final pickerNotifier = Provider.of<ImagePickerProvider>(context);
    final data = FirebaseFirestore.instance
        .collection("UserData")
        .doc(auth.currentUser!.email.toString())
        .get();
    DatabaseServices db = DatabaseServices();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SafeArea(
                    child: Text(
                      truckNumber.toString(),
                      textAlign: TextAlign.center,
                      style: ThemeOfApp.headingTextStyle,
                    ),
                  ),
                  rowAndTextFields(
                      context,
                      _startDate,
                      "Start Date",
                      pickerNotifier.formattedDate.isEmpty
                          ? "Month Start date"
                          : pickerNotifier.formattedDate,
                      TextInputType.datetime,
                      true, () {
                    pickerNotifier.dateTimePicker(context);
                  }),
                  rowAndTextFields(
                      context,
                      _startDate,
                      "End Date",
                      pickerNotifier.formattedDateDi.isEmpty
                          ? "Month End date"
                          : pickerNotifier.formattedDateDi,
                      TextInputType.datetime,
                      true, () {
                    pickerNotifier.dateTimePickerDi(context);
                  }),
                  SizedBox(height: 10.h),
                  Text(
                    "expenses :",
                    style: ThemeOfApp.subHeadingTextStyle,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: rowAndTextFields(
                            context,
                            _garage,
                            "Garage",
                            "Total Garage Expanses",
                            TextInputType.number,
                            false,
                            () {}),
                      ),
                      Expanded(
                        child: rowAndTextFields(
                            context,
                            _diesel,
                            "Diesel",
                            "Total diesel Expanses",
                            TextInputType.number,
                            false,
                            () {}),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: rowAndTextFields(
                            context,
                            _maintenance,
                            "Maintenance",
                            "Total Maintenance",
                            TextInputType.number,
                            false,
                            () {}),
                      ),
                      Expanded(
                        child: rowAndTextFields(
                            context,
                            _toll,
                            "Toll",
                            "Total Toll Tax Monthly",
                            TextInputType.number,
                            false,
                            () {}),
                      ),
                    ],
                  ),
                  rowAndTextFields(
                      context,
                      _wheel,
                      "Wheel",
                      "Total Wheel Expanses Monthly",
                      TextInputType.number,
                      false,
                      () {}),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: FutureBuilder(
                  future: data,
                  builder: (context, snapshot) {
                    return commonButton(context, "Save", () {
                      if (pickerNotifier.formattedDate.isEmpty ||
                          pickerNotifier.formattedDateDi.isEmpty ||
                          _garage.text.isEmpty ||
                          _diesel.text.isEmpty ||
                          _maintenance.text.isEmpty ||
                          _toll.text.isEmpty ||
                          _wheel.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fill All Fields")));
                      } else {
                        final total = int.parse(_garage.text) +
                            int.parse(_wheel.text) +
                            int.parse(_toll.text) +
                            int.parse(_maintenance.text) +
                            int.parse(_diesel.text);
                        Future.microtask(() async {
                          final data = await TruckPdfPageOpen.generate(
                              context,
                              snapshot.data!["CompanyName"],
                              snapshot.data!["CompanyAddress"],
                              snapshot.data!["CompanyNumber"],
                              snapshot.data!["CompanyEmail"],
                              pickerNotifier.formattedDateDi,
                              pickerNotifier.formattedDate,
                              _garage.text.toString(),
                              _diesel.text.toString(),
                              _maintenance.text.toString(),
                              _toll.text.toString(),
                              _wheel.text.toString(),
                              total);
                          TruckPdfPageOpen.savePdf(truckNumber, data);
                        });
                        db
                            .truckDetailsData(
                                context,
                                truckNumber,
                                pickerNotifier.formattedDate,
                                pickerNotifier.formattedDateDi,
                                _garage.text.toString(),
                                _diesel.text.toString(),
                                _maintenance.text.toString(),
                                _toll.text.toString(),
                                _wheel.text.toString(),
                                total)
                            .then((value) {
                          _garage.clear();
                          _diesel.clear();
                          _maintenance.clear();
                          _toll.clear();
                          _wheel.clear();
                        });
                      }
                    });
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget rowAndTextFields(
    BuildContext context,
    TextEditingController controller,
    String name,
    String hint,
    TextInputType keyboardType,
    bool? readOnly,
    VoidCallback? onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          readOnly: readOnly!,
          onTap: onTap,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 15.sp,
                color: Colors.black.withOpacity(0.4),
                fontWeight: FontWeight.bold),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.9))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
          ),
        ),
      ],
    ),
  );
}
