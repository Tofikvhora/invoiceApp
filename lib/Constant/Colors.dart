import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeOfApp {
  static const primaryColor = Color(0xff212529);
  static const secondaryColor = Color(0xff6c757d);
  static const textColor = Color(0xffe9ecef);
  static const backgroundColor = Color(0xffced4da);
  static const shadow = Color(0xffe9ecef);

  static TextStyle headingTextStyle = TextStyle(
      fontSize: 18.sp,
      color: textColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.w);
  static TextStyle subHeadingTextStyle = TextStyle(
      fontSize: 15.sp,
      color: textColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 1);
  static TextStyle smallTextStyle = TextStyle(
      fontSize: 12.sp,
      color: textColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 1);
}
