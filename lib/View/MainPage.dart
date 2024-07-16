import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Utils/MainList.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';

class MainPage extends HookWidget {
  static const String route = "MainPage";
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummy = [
      "Generate Invoice Within second",
      "Manage your all truck in one place",
      "Manage all your party in secure place",
      "Manage your BUY_SELL data at secure place",
      "All your invoice data at secure place",
    ];
    final firestore = FirebaseFirestore.instance;
    final fsName = firestore.collection("UserData").get();
    final fAuth = FirebaseAuth.instance;
    return Scaffold(
      body: FutureBuilder(
        future: fsName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: ThemeOfApp.primaryColor,
            ));
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            children: [
              commonAppBar(context),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 15.h),
                  itemCount: MainList.items(context).length,
                  itemBuilder: (context, index) {
                    final item = MainList.items(context)[index];
                    return InkWell(
                      onTap: item.onTap,
                      child: Container(
                        width: 150.w,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ThemeOfApp.shadow.withOpacity(0.1),
                          boxShadow: const [
                            BoxShadow(
                              color: ThemeOfApp.primaryColor,
                              blurStyle: BlurStyle.outer,
                              blurRadius: 7,
                              spreadRadius: 1.5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              width: 80.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ThemeOfApp.primaryColor.withOpacity(0.1),
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
                                  item.image,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                item.name.toString(),
                                textAlign: TextAlign.start,
                                style: ThemeOfApp.subHeadingTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    letterSpacing: 1.w),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                dummy[index].toString(),
                                textAlign: TextAlign.start,
                                style: ThemeOfApp.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11.w,
                                    letterSpacing: 1.w),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
