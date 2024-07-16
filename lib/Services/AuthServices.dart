import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newmahirroadways/Constant/UserKey.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/MainPage.dart';
import 'package:newmahirroadways/View/auth/EmailVerification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  DatabaseServices db = DatabaseServices();
  final _fb = FirebaseAuth.instance;
  Future<void> emailVerification(BuildContext context) async {
    await _fb.currentUser!.sendEmailVerification();
  }

  Future<void> loginFunction(
      TextEditingController email,
      TextEditingController password,
      BuildContext context,
      bool isloading) async {
    isloading = false;
    try {
      isloading = true;
      await _fb
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successfully 🎊 ")));
        MainPage.route.pushAndReplace(context);
        isloading = false;
        SharedPreferences sf = await SharedPreferences.getInstance();
        await sf.setString(UserKeys.emailkey, email.text);
      });
    } on FirebaseAuthException catch (e) {
      isloading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> signIn(
      TextEditingController email,
      TextEditingController name,
      TextEditingController password,
      BuildContext context,
      bool isloading) async {
    try {
      isloading = true;
      await _fb
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        isloading = false;
        EmailVerification.route.pushOnThis(context);
        await db.uploadUserName(name, email, context);
        SharedPreferences sf = await SharedPreferences.getInstance();
        await sf.setString(UserKeys.emailkey, email.text);
      });
    } on FirebaseAuthException catch (e) {
      isloading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
