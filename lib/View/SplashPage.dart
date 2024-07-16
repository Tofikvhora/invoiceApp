import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Constant/UserKey.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/MainPage.dart';
import 'package:newmahirroadways/View/auth/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends HookWidget {
  static const String route = 'SplashPage';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () async {
        SharedPreferences sf = await SharedPreferences.getInstance();
        var isLogin = await sf.getString(UserKeys.emailkey);
        isLogin == null
            ? LoginPage.route.pushAndReplace(context)
            : MainPage.route.pushAndReplace(context);
      });
      return () {};
    }, []);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "asset/images/invoice.png",
                    width: 200.w,
                    height: 150.h,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: ThemeOfApp.primaryColor,
              strokeAlign: 0.2,
              strokeCap: StrokeCap.square,
              backgroundColor: ThemeOfApp.backgroundColor,
            ),
          )
        ],
      ),
    );
  }
}
