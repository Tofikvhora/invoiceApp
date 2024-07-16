import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';
import 'package:newmahirroadways/Widget/PdfPage.dart';
import 'package:newmahirroadways/provider/AddDataFunction.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends HookWidget {
  static const String route = 'HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseServices db = DatabaseServices();
    final firestore = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    final pickerNotifier = Provider.of<ImagePickerProvider>(context);
    final auth = FirebaseAuth.instance;
    final _srController = useTextEditingController();
    final _amount = useTextEditingController();
    final _from = useTextEditingController();
    final _to = useTextEditingController();
    final _feet = useTextEditingController();
    final _hold = useTextEditingController();
    final _date = useTextEditingController();
    final _vehicle = useTextEditingController();
    final _pdfName = useTextEditingController();
    final _billNumber = useTextEditingController();
    final _hr = useTextEditingController();
    final isSave = useState<bool>(false);
    final PdfPage pdfPage = PdfPage();
    final notifier = Provider.of<AddDataProvider>(context);
    final diNotifier = Provider.of<DieselProvider>(context);
    final name = useState("");
    final data = firestore
        .collection("UserData")
        .doc(auth.currentUser!.email.toString())
        .get();
    final invoiceData = firestore
        .collection("InvoiceData")
        .doc(auth.currentUser!.email.toString())
        .collection("InvoiceList")
        .doc(notifier.srNO.toString())
        .get();

    useEffect(() {
      return () {
        notifier.srNO = 1;
        _pdfName.clear();
        name.value = "";
        _billNumber.clear();
        notifier.total = 0;
        notifier.labourCharges = 0;
        notifier.totalDay = 0;
        diNotifier.srNO = 1;
        diNotifier.total = 0;
        diNotifier.totalLiter = 0;
        notifier.day = 0;
      };
    }, []);
    final isPop = useState(false);

    return Scaffold(
      body: Column(
        children: [
          commonAppBar(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: FutureBuilder(
                      future: invoiceData,
                      builder: (context, snapshot) {
                        return rowAndTextFields(
                            context,
                            _pdfName,
                            "PDF NAME :",
                            name.value.isEmpty ? "PDF Name" : name.value,
                            TextInputType.text,
                            name.value.isEmpty ? false : true,
                            null);
                      },
                    )),
                    Expanded(
                      child: rowAndTextFields(
                          context,
                          _billNumber,
                          "BILL NO :",
                          "Enter Bill Number",
                          TextInputType.number,
                          false,
                          null),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: FutureBuilder(
                      future: invoiceData,
                      builder: (context, snapshot) {
                        return rowAndTextFields(
                            context,
                            _srController,
                            "SR NO :",
                            notifier.srNO.toString(),
                            TextInputType.number,
                            true,
                            null);
                      },
                    )),
                    Expanded(
                      child: rowAndTextFields(context, _amount, "AMOUNT :",
                          "Enter Amount", TextInputType.number, false, null),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: rowAndTextFields(
                          context,
                          _from,
                          "FROM :",
                          "From EX: Ahmedabad",
                          TextInputType.text,
                          false,
                          null),
                    ),
                    Expanded(
                        child: rowAndTextFields(context, _to, "TO :",
                            "To EX: Surat", TextInputType.text, false, null)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: rowAndTextFields(
                          context,
                          _feet,
                          "Feet :",
                          "Enter Feet Ex: 22,23",
                          TextInputType.number,
                          false,
                          null),
                    ),
                    Expanded(
                      child: rowAndTextFields(context, _hold, "HOLD IN DAYS :",
                          "Holding Days", TextInputType.number, false, null),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: rowAndTextFields(
                            context,
                            _date,
                            "DATE : ",
                            pickerNotifier.formattedDate == ""
                                ? "Enter Date "
                                : pickerNotifier.formattedDate,
                            TextInputType.datetime,
                            true, () {
                      pickerNotifier.dateTimePicker(context);
                    })),
                    Expanded(
                        child: rowAndTextFields(
                            context,
                            _vehicle,
                            "VEHICLE NO :",
                            "Enter Vehicle No",
                            TextInputType.text,
                            false,
                            null)),
                  ],
                ),
                Expanded(
                    child: rowAndTextFields(context, _hr, "Hr Number :",
                        "Enter hr No", TextInputType.text, false, null)),
                isSave.value == false
                    ? Consumer<AddDataProvider>(
                        builder: (context, value, child) {
                          return FutureBuilder(
                            future: invoiceData,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  if (_pdfName.text.isEmpty &&
                                      _billNumber.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Fields Can't be Empty",
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      showCloseIcon: true,
                                      closeIconColor: Colors.white,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black,
                                    ));
                                  } else {
                                    name.value = _pdfName.text.toString();
                                    firestore
                                        .collection("InvoiceNames")
                                        .doc(auth.currentUser!.email.toString())
                                        .collection("Name")
                                        .doc(name.value.toString())
                                        .set({
                                      "InvoiceName": _pdfName.text.toString(),
                                      "Created": formattedDate,
                                      "BillNumber": _billNumber.text.toString()
                                    });
                                    notifier.srNOFunctions();
                                    notifier.dayLogic(_hold);
                                    notifier.totalFunction(_amount);
                                    // notifier
                                    //     .totalLabourCharges(_labour);

                                    db
                                        .invoiceData(
                                            notifier.srNO - 1,
                                            pickerNotifier.formattedDate,
                                            _vehicle,
                                            _from,
                                            _to,
                                            _feet,
                                            notifier.day.toString(),
                                            _amount,
                                            context)
                                        .then((value) {
                                      db
                                          .saveInvoiceData(
                                              notifier.srNO - 1,
                                              pickerNotifier.formattedDate,
                                              _vehicle,
                                              _from,
                                              _to,
                                              _feet,
                                              notifier.day.toString(),
                                              _amount,
                                              _pdfName,
                                              context)
                                          .then((value) {
                                        formattedDate = "";
                                        pickerNotifier.formattedDate = "";
                                        _hold.clear();
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: ThemeOfApp.primaryColor,
                                            blurRadius: 8,
                                            blurStyle: BlurStyle.outer,
                                            spreadRadius: 1.5)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "ADD Data",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.w),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const SizedBox(),
                isSave.value == false
                    ? InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WillPopScope(
                                onWillPop: () async {
                                  return false;
                                },
                                child: AlertDialog(
                                  backgroundColor: ThemeOfApp.primaryColor,
                                  shadowColor: Colors.white,
                                  elevation: 5,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            isSave.value = false;
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: ThemeOfApp.headingTextStyle
                                                .copyWith(color: Colors.red),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            isSave.value = true;
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Save",
                                            style: ThemeOfApp.headingTextStyle
                                                .copyWith(
                                                    color: ThemeOfApp.shadow),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  icon: const Icon(
                                    Icons.info,
                                    color: ThemeOfApp.shadow,
                                    weight: 5,
                                  ),
                                  title: Text(
                                    "Make Sure you have added all entry's",
                                    style: ThemeOfApp.subHeadingTextStyle
                                        .copyWith(color: ThemeOfApp.shadow),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                              boxShadow: const [
                                BoxShadow(
                                    color: ThemeOfApp.primaryColor,
                                    blurRadius: 8,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 1.5)
                              ]),
                          child: Center(
                            child: Text(
                              "Save PDF",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.w),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          isSave.value == true
              ? Consumer<AddDataProvider>(
                  builder: (context, value, child) {
                    return FutureBuilder(
                      future: data,
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () async {
                            if (_pdfName.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                              await FirebaseFirestore.instance
                                  .collection("TotalDataSave")
                                  .doc(auth.currentUser!.email.toString())
                                  .collection(name.value.toString())
                                  .add({
                                "InvoiceTotal": notifier.total,
                                "InvoiceDay": notifier.totalDay,
                                "InvoiceLabourCharges": notifier.labourCharges,
                                "DiTotal": diNotifier.total,
                                "DiTotalLitters": diNotifier.totalLiter,
                              });
                              Future.microtask(() async {
                                final data = await PdfPage.generate(
                                    context,
                                    snapshot.data!["CompanyName"],
                                    snapshot.data!["CompanyAddress"],
                                    snapshot.data!["CompanyNumber"],
                                    snapshot.data!["CompanyEmail"],
                                    value.total,
                                    value.labourCharges,
                                    value.day,
                                    value.billDate,
                                    diNotifier.total,
                                    diNotifier.totalLiter);
                                PdfPage.savePdf(_pdfName.text.toString(), data);
                              }).then((value) {
                                firestore
                                    .collection('InvoiceData')
                                    .doc(auth.currentUser!.email.toString())
                                    .collection("InvoiceList")
                                    .get()
                                    .then((snapshot) {
                                  for (DocumentSnapshot ds in snapshot.docs) {
                                    ds.reference.delete();
                                  }
                                  ;
                                });
                                firestore
                                    .collection('InvoiceData')
                                    .doc(auth.currentUser!.email.toString())
                                    .collection("DieselInvoiceList")
                                    .get()
                                    .then((snapshot) {
                                  for (DocumentSnapshot ds in snapshot.docs) {
                                    ds.reference.delete();
                                  }
                                  ;
                                }).then((value) {
                                  isSave.value = false;
                                  notifier.srNO = 1;
                                  _pdfName.clear();
                                  name.value = "";
                                  _billNumber.clear();
                                  notifier.total = 0;
                                  notifier.labourCharges = 0;
                                  notifier.totalDay = 0;
                                  diNotifier.srNO = 1;
                                  diNotifier.total = 0;
                                  diNotifier.totalLiter = 0;
                                  notifier.day = 0;
                                });
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                                boxShadow: const [
                                  BoxShadow(
                                      color: ThemeOfApp.primaryColor,
                                      blurRadius: 8,
                                      blurStyle: BlurStyle.outer,
                                      spreadRadius: 1.5)
                                ]),
                            child: Center(
                              child: Text(
                                "Generate PDF",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.w),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : const SizedBox(),
        ],
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
