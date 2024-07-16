import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';

Widget commonButton(BuildContext context, String name, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
      alignment: Alignment.center,
      height: 40.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: ThemeOfApp.primaryColor,
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
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: ThemeOfApp.headingTextStyle.copyWith(color: Colors.white),
      ),
    ),
  );
}
