import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';
import 'package:newmahirroadways/Widget/CommonButton.dart';

class FindTruck extends HookWidget {
  static const String route = "FindTruck";
  const FindTruck({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    DatabaseServices db = DatabaseServices();
    final auth = FirebaseAuth.instance;
    final _newTruck = useTextEditingController();
    final editName = useState<String>("");
    final name = useState("");
    final searchText = useState("");
    final firestore = FirebaseFirestore.instance
        .collection("TruckData")
        .doc(auth.currentUser!.email.toString())
        .collection("TruckNumber")
        .snapshots();
    final _search = useTextEditingController();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        children: [
          commonAppBar(context),
          TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              searchText.value = value;
              Future.delayed(const Duration(microseconds: 100), () {
                _search.clear();
              });
            },
            onChanged: (value) {
              if (_search.text != value.toUpperCase()) {
                _search.value =
                    _search.value.copyWith(text: value.toUpperCase());
              }
            },
            textCapitalization: TextCapitalization.characters,
            controller: _search,
            style: ThemeOfApp.subHeadingTextStyle
                .copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "Search by Last Number ex : 4125",
              hintStyle: ThemeOfApp.subHeadingTextStyle,
              prefixIcon: Icon(
                Icons.car_crash,
                size: 25.w,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: ThemeOfApp.primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: ThemeOfApp.primaryColor, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: StreamBuilder(
              stream: firestore,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: ThemeOfApp.primaryColor));
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("Add Truck's 🚚",
                        style: ThemeOfApp.headingTextStyle
                            .copyWith(color: ThemeOfApp.primaryColor)),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          "Something want Wrong try again after some time",
                          style: ThemeOfApp.headingTextStyle
                              .copyWith(color: ThemeOfApp.primaryColor)));
                }
                return snapshot.data!.docs.isEmpty
                    ? Center(
                        child: Center(
                            child: Text(
                          "No Truck Data exist",
                          style: ThemeOfApp.headingTextStyle,
                        )),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: Text(
                              "Total Trucks : ${snapshot.data!.docs.length.toString()}",
                              style: ThemeOfApp.smallTextStyle
                                  .copyWith(color: ThemeOfApp.primaryColor),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data!.docs[index];
                                return data["TruckNumber"]
                                        .toString()
                                        .endsWith(searchText.value)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 7.w),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 150.h,
                                              decoration: BoxDecoration(
                                                  color: ThemeOfApp.shadow,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: ThemeOfApp
                                                            .primaryColor,
                                                        spreadRadius: 2,
                                                        blurStyle:
                                                            BlurStyle.outer,
                                                        blurRadius: 4),
                                                    BoxShadow(
                                                        color: ThemeOfApp
                                                            .primaryColor,
                                                        spreadRadius: 2,
                                                        blurStyle:
                                                            BlurStyle.outer,
                                                        blurRadius: 4),
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w),
                                                          width: 80.w,
                                                          height: 70.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: ThemeOfApp
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color:
                                                                    ThemeOfApp
                                                                        .shadow,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .inner,
                                                                blurRadius: 7,
                                                                spreadRadius:
                                                                    1.5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Image.asset(
                                                                "asset/images/box-truck.png"),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                        height: 15.h,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            data["TruckNumber"]
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: ThemeOfApp
                                                                .headingTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        19.sp),
                                                          ),
                                                          Text(
                                                            data["Created"]
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: ThemeOfApp
                                                                .smallTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return WillPopScope(
                                                                    onWillPop:
                                                                        () async {
                                                                      return false;
                                                                    },
                                                                    child:
                                                                        AlertDialog(
                                                                      shadowColor:
                                                                          ThemeOfApp
                                                                              .primaryColor,
                                                                      backgroundColor:
                                                                          ThemeOfApp
                                                                              .shadow,
                                                                      elevation:
                                                                          10,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      title:
                                                                          Text(
                                                                        "New truck number",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: ThemeOfApp
                                                                            .subHeadingTextStyle,
                                                                      ),
                                                                      actions: [
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            TextField(
                                                                              onChanged: (value) {
                                                                                if (_newTruck.text != value.toUpperCase()) {
                                                                                  _newTruck.value = _newTruck.value.copyWith(text: value.toUpperCase());
                                                                                }
                                                                              },
                                                                              textCapitalization: TextCapitalization.characters,
                                                                              controller: _newTruck,
                                                                              style: ThemeOfApp.subHeadingTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                                              decoration: InputDecoration(
                                                                                hintText: "Enter new number",
                                                                                hintStyle: ThemeOfApp.subHeadingTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold, color: ThemeOfApp.primaryColor),
                                                                                prefixIcon: Icon(
                                                                                  Icons.car_crash,
                                                                                  size: 25.w,
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
                                                                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ThemeOfApp.primaryColor, width: 1)),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ThemeOfApp.primaryColor, width: 2)),
                                                                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: commonButton(context, "Cancel", () => Navigator.pop(context)),
                                                                                ),
                                                                                Expanded(
                                                                                  child: commonButton(context, "Update", () {
                                                                                    if (_newTruck.text.isEmpty) {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter truck number please ")));
                                                                                    } else {
                                                                                      editName.value = data["TruckNumber"].toString();
                                                                                      FirebaseFirestore.instance.collection("TruckData").doc(auth.currentUser!.email.toString()).collection("TruckNumber").doc(editName.value).update({
                                                                                        "TruckNumber": _newTruck.text.toString(),
                                                                                      }).then((value) {
                                                                                        editName.value = _newTruck.text.toString();
                                                                                        _newTruck.clear();
                                                                                        Navigator.pop(context);
                                                                                      });
                                                                                    }
                                                                                  }),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          padding: EdgeInsets
                                                              .zero,
                                                          highlightColor:
                                                              ThemeOfApp
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.3),
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 30.w,
                                                            color: ThemeOfApp
                                                                .primaryColor,
                                                          )),
                                                      IconButton(
                                                          padding: EdgeInsets
                                                              .zero,
                                                          onPressed: () async {
                                                            name.value = data[
                                                                    "OldTruckNumber"]
                                                                .toString();
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "TruckData")
                                                                .doc(auth
                                                                    .currentUser!
                                                                    .email
                                                                    .toString())
                                                                .collection(
                                                                    "TruckNumber")
                                                                .doc(name.value)
                                                                .delete();
                                                          },
                                                          highlightColor:
                                                              ThemeOfApp
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.3),
                                                          icon: Icon(
                                                            Icons.delete,
                                                            size: 30.w,
                                                            color: ThemeOfApp
                                                                .primaryColor,
                                                          )),
                                                      IconButton(
                                                          padding: EdgeInsets
                                                              .zero,
                                                          onPressed: () {},
                                                          highlightColor:
                                                              ThemeOfApp
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.3),
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_double_arrow_right,
                                                            size: 30.w,
                                                            color: ThemeOfApp
                                                                .primaryColor,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ],
                                      )
                                    : const SizedBox();
                                // : SizedBox(
                                //     height:
                                //         MediaQuery.of(context).size.height *
                                //             0.6,
                                //     child: Column(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Icon(Icons.error,
                                //             size: 35.w, color: Colors.red),
                                //         Center(
                                //           child: Text(
                                //             "truck number not found",
                                //             style:
                                //                 ThemeOfApp.headingTextStyle,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   );
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
