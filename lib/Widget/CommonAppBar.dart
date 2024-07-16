import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget commonAppBar(BuildContext context) {
  final firestore = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  final fsName = firestore
      .collection("UserData")
      .doc(fAuth.currentUser!.email.toString())
      .snapshots();
  return StreamBuilder(
    stream: fsName,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return SizedBox(
          height: 80.h,
        );
      }
      return SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.exists == false
                            ? "Guest"
                            : snapshot.data!["CompanyName"].toString(),
                        style: ThemeOfApp.headingTextStyle
                            .copyWith(fontSize: 15.sp),
                      ),
                      Text(
                        snapshot.data!.exists == false
                            ? "1234567895"
                            : snapshot.data!["CompanyNumber"].toString(),
                        style: ThemeOfApp.headingTextStyle.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () async {
                  SharedPreferences sf = await SharedPreferences.getInstance();
                  sf.clear();
                },
                icon: Icon(
                  Icons.settings,
                  size: 30.w,
                  opticalSize: 50,
                  shadows: const [
                    BoxShadow(
                        color: ThemeOfApp.primaryColor,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(1.5, 2.5))
                  ],
                  color: ThemeOfApp.primaryColor,
                ))
          ],
        ),
      );
    },
  );
}
