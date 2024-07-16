import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

import '../Services/DatabaseServices.dart';

class DieselPage extends HookWidget {
  String pdfName = "";
  static const String route = 'DieselPage';
  DieselPage({super.key, required this.pdfName});

  @override
  Widget build(BuildContext context) {
    final DatabaseServices db = DatabaseServices();
    final firestore = FirebaseFirestore.instance;

    final auth = FirebaseAuth.instance;
    final _srController = useTextEditingController();
    final _amount = useTextEditingController();
    final _liters = useTextEditingController();
    final _date = useTextEditingController();
    final _vehicle = useTextEditingController();
    final notifier = Provider.of<DieselProvider>(context);
    final isPop = useState(false);
    final pickerNotifier = Provider.of<ImagePickerProvider>(context);
    useEffect(() {
      return () {
        notifier.srNO = 1;
      };
    }, []);
    return Scaffold(
      body: Column(
        children: [
          commonAppBar(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("SR NO",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              readOnly: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              controller: _srController,
                              decoration: InputDecoration(
                                hintText: '${notifier.srNO}',
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.9))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Amount ",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              controller: _amount,
                              decoration: InputDecoration(
                                hintText: 'Amount..',
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.9))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Liters ",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _liters,
                        decoration: InputDecoration(
                          hintText: 'Liter',
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.9))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5))),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Date",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              onTap: () {
                                pickerNotifier.dateTimePickerDi(context);
                              },
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              controller: _date,
                              decoration: InputDecoration(
                                hintText: pickerNotifier.formattedDateDi == ""
                                    ? 'Date Ex : May 1'
                                    : pickerNotifier.formattedDateDi,
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.9))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Vehicle NO",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: _vehicle,
                              decoration: InputDecoration(
                                hintText: 'Vehicle Number',
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.9))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer<DieselProvider>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  if (_vehicle.text.isEmpty ||
                      _liters.text.isEmpty ||
                      _amount.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Fields Can't be Empty",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      showCloseIcon: true,
                      closeIconColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.black,
                    ));
                  } else {
                    notifier.srNOFunctions();
                    notifier.totalFunction(_amount);
                    notifier.totalLiters(_liters);
                    db
                        .dieselInvoice(
                      notifier.srNO - 1,
                      _amount,
                      _liters,
                      pickerNotifier.formattedDateDi.toString(),
                      _vehicle,
                      context,
                    )
                        .then((value) {
                      db
                          .saveInvoiceDiesel(
                              notifier.srNO - 1,
                              _amount,
                              _liters,
                              pickerNotifier.formattedDateDi.toString(),
                              _vehicle,
                              pdfName.toString(),
                              context)
                          .then((value) => pickerNotifier.formattedDateDi = "");
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 50.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.5, 0.8),
                          blurStyle: BlurStyle.solid,
                          spreadRadius: 1.5,
                          blurRadius: 2.5,
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      "ADD Data",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.w),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
