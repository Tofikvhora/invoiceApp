import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/DieselPage.dart';
import 'package:newmahirroadways/Widget/PdfPage.dart';
import 'package:newmahirroadways/provider/AddDataFunction.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends HookWidget {
  static const String route = 'HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _srController = useTextEditingController();
    final _amount = useTextEditingController();
    final _from = useTextEditingController();
    final _to = useTextEditingController();
    final _labour = useTextEditingController();
    final _hold = useTextEditingController();
    final _date = useTextEditingController();
    final _vehicle = useTextEditingController();
    final _companyName = useTextEditingController();
    final _pdfName = useTextEditingController();
    final _billDate = useTextEditingController();
    final PdfPage pdfPage = PdfPage();
    final notifier = Provider.of<AddDataProvider>(context);
    final diNotifier = Provider.of<DieselProvider>(context);

    useEffect(() {
      return () {
        notifier.alldata.clear();
        notifier.pdfName = '';
        notifier.companyNameString = '';
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 10,
        actions: [
          InkWell(
            onTap: () {
              DieselPage.route.pushOnThis(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: 80.w,
              height: 30.h,
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: Text(
                "Diesel Form",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: Colors.white),
              ),
            ),
          )
        ],
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Consumer<AddDataProvider>(
                  builder: (context, value, child) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Your Company Name",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: _companyName,
                            readOnly:
                                value.companyNameString.isEmpty ? false : true,
                            decoration: InputDecoration(
                              hintText: value.companyNameString.isEmpty
                                  ? 'Company Name'
                                  : value.companyNameString,
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
                    );
                  },
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
                              child: Text("FROM",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: _from,
                              decoration: InputDecoration(
                                hintText: 'FROM Ex : Ahmedabad',
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
                              child: Text("TO ",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: _to,
                              decoration: InputDecoration(
                                hintText: 'TO Ex : Ahmedabad',
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
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10),
                                //     borderSide: BorderSide(
                                //         color: Colors.black.withOpacity(0.5)))
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                              child: Text("Labour Amount",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: _labour,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                hintText: 'Labour Amount',
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
                              child: Text("Hold",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              controller: _hold,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Hold Ex : 1 or 2 ',
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
                              keyboardType: TextInputType.datetime,
                              controller: _date,
                              decoration: InputDecoration(
                                hintText: 'Date Ex : May 1',
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Bill Date ",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: _billDate,
                        decoration: InputDecoration(
                          hintText: 'Bill Date Ex final bill date',
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<AddDataProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () async {
                      if (value.pdfName.isEmpty || value.pdfName == '') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 120.h),
                              child: SingleChildScrollView(
                                child: Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Colors.black,
                                  elevation: 10,
                                  shadowColor: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 80.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Pdf Name",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        TextFormField(
                                          controller: _pdfName,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Pdf Name',
                                            hintStyle: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.9))),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5))),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5))),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (value.pdfName.isEmpty ||
                                                    value.pdfName == '') {
                                                  value.pdfNameFunction(
                                                      _pdfName, _billDate);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 80.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white),
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 80.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white),
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        if (value.alldata.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data is Empty",
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
                          final data = await PdfPage.generate(
                              context,
                              value.alldata,
                              value.companyNameString.toString(),
                              value.total,
                              value.labourCharges,
                              value.totalDay,
                              value.billDate,
                              diNotifier.alldata,
                              diNotifier.total,
                              diNotifier.totalLiter);
                          PdfPage.savePdf(value.pdfName, data);
                        }
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
                          "Generate PDF",
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
              Consumer<AddDataProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      if (_vehicle.text.isEmpty ||
                          _date.text.isEmpty ||
                          _hold.text.isEmpty ||
                          _labour.text.isEmpty ||
                          _from.text.isEmpty ||
                          _to.text.isEmpty ||
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
                        notifier.dayLogic(_hold);
                        notifier.totalFunction(_amount);
                        notifier.totalLabourCharges(_labour);
                        value.addAllData(
                          notifier.srNO - 1,
                          _amount,
                          _from,
                          _to,
                          _labour,
                          '${notifier.day} Day',
                          _date,
                          _vehicle,
                          _companyName,
                          context,
                        );
                        Future.delayed(const Duration(microseconds: 100), () {
                          _srController.clear();
                          _amount.clear();
                          _from.clear();
                          _to.clear();
                          _hold.clear();
                          _date.clear();
                          _vehicle.clear();
                          _labour.clear();
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
          )
        ],
      ),
    );
  }
}
