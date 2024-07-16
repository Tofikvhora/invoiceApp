import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/AuthServices.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/InfoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerification extends HookWidget {
  static const String route = "EmailVerification";
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    final timer = useState<Timer?>(null);
    useEffect(() {
      authServices.emailVerification(context);
      timer.value = Timer.periodic(const Duration(seconds: 20), (timer) async {
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
          InfoPage.route.pushAndReplace(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Register Successfully 🎊 ")));
          timer.cancel();
        } else {
          SharedPreferences sf = await SharedPreferences.getInstance();
          sf.clear();
          timer.cancel();
          await FirebaseAuth.instance.currentUser!.delete();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("email verification Timeout try again 🎊 ")));
        }
      });
      return () {
        timer.value!.cancel();
      };
    }, []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.email, size: 80.w, color: ThemeOfApp.primaryColor),
          Text(
            "We have Sent you email verification link Please verify email to continue",
            textAlign: TextAlign.center,
            style: ThemeOfApp.subHeadingTextStyle,
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
