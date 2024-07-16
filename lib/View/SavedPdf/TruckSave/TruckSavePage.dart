import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/View/TruckPages/TruckPdfPageOpen.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';

import '../../../Constant/Colors.dart';

class TruckSavePage extends HookWidget {
  static const String route = "TruckSavePage";
  const TruckSavePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final name = useState("");
    final userdata = FirebaseFirestore.instance
        .collection("UserData")
        .doc(auth.currentUser!.email.toString())
        .get();

    final snapShotData = FirebaseFirestore.instance
        .collection("TruckDetailsData")
        .doc(auth.currentUser!.email.toString())
        .collection("TruckDetailsNumber")
        .snapshots();
    return Scaffold(
      body: ListView(
        children: [
          commonAppBar(context),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
              stream: snapShotData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ThemeOfApp.primaryColor,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                      child: Text("Data Not Found",
                          style: ThemeOfApp.headingTextStyle));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.w,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: 0.79),
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return FutureBuilder(
                      future: userdata,
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () {
                            Future.microtask(() async {
                              final pdf = await TruckPdfPageOpen.generate(
                                  context,
                                  snapshot.data!["CompanyName"],
                                  snapshot.data!["CompanyAddress"],
                                  snapshot.data!["CompanyNumber"],
                                  snapshot.data!["CompanyEmail"],
                                  data["StartDate"].toString(),
                                  data["EndDate"].toString(),
                                  data["Garage"].toString(),
                                  data["Diesel"].toString(),
                                  data["Maintenance"].toString(),
                                  data["TollTax"].toString(),
                                  data["Wheel"].toString(),
                                  data["Total"]);
                              TruckPdfPageOpen.savePdf(data["TruckName"], pdf);
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 7.w),
                              width: MediaQuery.of(context).size.width,
                              height: 170.h,
                              decoration: BoxDecoration(
                                  color: ThemeOfApp.shadow,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: ThemeOfApp.primaryColor,
                                        spreadRadius: 2,
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 4),
                                    BoxShadow(
                                        color: ThemeOfApp.primaryColor,
                                        spreadRadius: 2,
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 4),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      width: 80.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ThemeOfApp.primaryColor
                                            .withOpacity(0.1),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: ThemeOfApp.shadow,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 7,
                                            spreadRadius: 1.5,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
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
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        data["TruckName"].toString(),
                                        textAlign: TextAlign.center,
                                        style: ThemeOfApp.headingTextStyle
                                            .copyWith(fontSize: 19.sp),
                                      ),
                                      SizedBox(
                                        width: 180.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(data["StartDate"].toString(),
                                                textAlign: TextAlign.start,
                                                style:
                                                    ThemeOfApp.smallTextStyle),
                                            SizedBox(
                                              width: 180.w,
                                              child: Text(
                                                "TO",
                                                textAlign: TextAlign.center,
                                                style:
                                                    ThemeOfApp.smallTextStyle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 180.w,
                                              child: Text(
                                                data["EndDate"].toString(),
                                                textAlign: TextAlign.end,
                                                style:
                                                    ThemeOfApp.smallTextStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
