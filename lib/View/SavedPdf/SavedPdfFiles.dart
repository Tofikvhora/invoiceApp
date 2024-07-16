import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/View/SavedPdf/SavedPdfOpen.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';
import 'package:newmahirroadways/provider/AddDataFunction.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

class SavedPdfFiles extends HookWidget {
  static const String route = "SavedPdfFile";
  const SavedPdfFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final totalInvoiceAmount = useState<int>(0);
    final totalDays = useState(0);
    final totalLabours = useState(0);
    final diTotal = useState(0);
    final diTotalLitter = useState(0);
    final DatabaseServices db = DatabaseServices();
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final invoiceName = useState<List?>(null);
    final invoiceBillNumber = useState<List?>(null);
    final created = useState<List?>(null);
    final notifier = Provider.of<AddDataProvider>(context);
    final diNotifier = Provider.of<DieselProvider>(context);
    final name = useState<String>("");
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
    final snapShotForUser = FirebaseFirestore.instance
        .collection("InvoiceNames")
        .doc(auth.currentUser!.email.toString())
        .collection("Name")
        .snapshots();
    return Scaffold(
      body: Column(
        children: [
          commonAppBar(context),
          Expanded(
            child: StreamBuilder(
              stream: snapShotForUser,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: ThemeOfApp.primaryColor));
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text("Data Not Found",
                          style: ThemeOfApp.headingTextStyle));
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final pdf =
                        snapshot.data!.docs[index]["InvoiceName"].toString();
                    return Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeOfApp.primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10.w),
                              Image.asset(
                                "asset/images/management.png",
                                width: 40.w,
                                height: 50.h,
                              ),
                              SizedBox(width: 5.w),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data!.docs[index]["InvoiceName"]}.pdf",
                                    style: ThemeOfApp.headingTextStyle.copyWith(
                                        color: Colors.white, fontSize: 8.sp),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]["Created"]
                                        .toString(),
                                    style: ThemeOfApp.headingTextStyle.copyWith(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.delete,
                                  size: 22.w,
                                  color: ThemeOfApp.shadow,
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: AlertDialog(
                                          backgroundColor:
                                              ThemeOfApp.primaryColor,
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
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: ThemeOfApp
                                                        .headingTextStyle
                                                        .copyWith(
                                                            color: ThemeOfApp
                                                                .shadow),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "InvoiceNames")
                                                        .doc(auth
                                                            .currentUser!.email
                                                            .toString())
                                                        .collection("Name")
                                                        .doc(pdf.toString())
                                                        .delete()
                                                        .onError((error,
                                                                stackTrace) =>
                                                            log(error
                                                                .toString()))
                                                        .then((value) async {
                                                      Navigator.pop(context);
                                                      await firestore
                                                          .collection(
                                                              "SaveInvoiceData")
                                                          .doc(auth.currentUser!
                                                              .email
                                                              .toString())
                                                          .collection(
                                                              pdf.toString())
                                                          .get()
                                                          .then((snapshot) {
                                                        for (DocumentSnapshot ds
                                                            in snapshot.docs) {
                                                          ds.reference.delete();
                                                        }
                                                      });
                                                      await firestore
                                                          .collection(
                                                              "TotalDataSave")
                                                          .doc(auth.currentUser!
                                                              .email
                                                              .toString())
                                                          .collection(
                                                              pdf.toString())
                                                          .get()
                                                          .then((snapshot) {
                                                        for (DocumentSnapshot ds
                                                            in snapshot.docs) {
                                                          ds.reference.delete();
                                                        }
                                                      });
                                                      await firestore
                                                          .collection(
                                                              "SaveInvoiceDieselData")
                                                          .doc(auth.currentUser!
                                                              .email
                                                              .toString())
                                                          .collection(
                                                              pdf.toString())
                                                          .get()
                                                          .then((snapshot) {
                                                        for (DocumentSnapshot ds
                                                            in snapshot.docs) {
                                                          ds.reference.delete();
                                                        }
                                                      });
                                                    });
                                                  },
                                                  child: Text(
                                                    "Anyway",
                                                    style: ThemeOfApp
                                                        .headingTextStyle
                                                        .copyWith(
                                                            color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          icon: const Icon(
                                            Icons.info,
                                            color: ThemeOfApp.shadow,
                                            weight: 5,
                                          ),
                                          title: Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "Do you really want to delete this ",
                                              style: ThemeOfApp
                                                  .subHeadingTextStyle
                                                  .copyWith(
                                                      color: ThemeOfApp.shadow),
                                            ),
                                            TextSpan(
                                              text: "$pdf.pdf",
                                              style: ThemeOfApp
                                                  .subHeadingTextStyle
                                                  .copyWith(color: Colors.red),
                                            )
                                          ])),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Consumer<AddDataProvider>(
                                builder: (BuildContext context, value,
                                    Widget? child) {
                                  return FutureBuilder(
                                    future: data,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color:
                                                    ThemeOfApp.primaryColor));
                                      }
                                      return IconButton(
                                          onPressed: () async {
                                            name.value = pdf;
                                            QuerySnapshot totalSnapshot =
                                                await firestore
                                                    .collection("TotalDataSave")
                                                    .doc(auth.currentUser!.email
                                                        .toString())
                                                    .collection(name.value)
                                                    .get();
                                            QuerySnapshot querySnapshot =
                                                await firestore
                                                    .collection(
                                                        "SaveInvoiceData")
                                                    .doc(auth.currentUser!.email
                                                        .toString())
                                                    .collection(name.value)
                                                    .get();
                                            QuerySnapshot querySnapshotDi =
                                                await firestore
                                                    .collection(
                                                        "SaveInvoiceDieselData")
                                                    .doc(auth.currentUser!.email
                                                        .toString())
                                                    .collection(name.value)
                                                    .get();
                                            for (var doc
                                                in totalSnapshot.docs) {
                                              totalInvoiceAmount.value =
                                                  doc["InvoiceTotal"];
                                            }

                                            for (var doc
                                                in totalSnapshot.docs) {
                                              totalDays.value =
                                                  doc["InvoiceDay"];
                                            }
                                            for (var doc
                                                in totalSnapshot.docs) {
                                              totalLabours.value =
                                                  doc["InvoiceLabourCharges"];
                                            }

                                            for (var doc
                                                in totalSnapshot.docs) {
                                              diTotal.value = doc["DiTotal"];
                                            }

                                            for (var doc
                                                in totalSnapshot.docs) {
                                              diTotalLitter.value =
                                                  doc["DiTotalLitters"];
                                            }

                                            List<List> diTable = [
                                              for (var doc
                                                  in querySnapshotDi.docs)
                                                doc["AllData"]
                                            ];
                                            List<List> table = [
                                              for (var doc
                                                  in querySnapshot.docs)
                                                doc["AllData"]
                                            ];
                                            Future.microtask(() async {
                                              final data =
                                                  await SavePdfPage.generate(
                                                context,
                                                table,
                                                diTable,
                                                snapshot.data!["CompanyName"],
                                                snapshot
                                                    .data!["CompanyAddress"],
                                                snapshot.data!["CompanyNumber"],
                                                snapshot.data!["CompanyEmail"],
                                                totalInvoiceAmount.value,
                                                totalLabours.value,
                                                totalDays.value,
                                                value.billDate,
                                                diTotal.value,
                                                diTotalLitter.value,
                                              );
                                              SavePdfPage.savePdf(
                                                  name.value.toString(), data);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.open_in_browser,
                                            size: 25.w,
                                            color: Colors.white,
                                          ));
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
