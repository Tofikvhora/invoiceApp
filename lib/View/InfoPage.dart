import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:newmahirroadways/View/auth/LoginPage.dart';
import 'package:newmahirroadways/Widget/CommonButton.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:provider/provider.dart';

class InfoPage extends HookWidget {
  static const String route = "InfoPage";
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ImagePickerProvider>(context);
    final _company = useTextEditingController();
    final _address = useTextEditingController();
    final _number = useTextEditingController();
    final _email = useTextEditingController();
    final isnext = useState(false);
    final firestore = FirebaseFirestore.instance;
    final fsName = firestore.collection("UserName").get();
    final fAuth = FirebaseAuth.instance;
    final DatabaseServices db = DatabaseServices();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: fsName,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome ",
                          style: ThemeOfApp.headingTextStyle
                              .copyWith(fontSize: 20.sp)),
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textFieldsCommon(
                        context, 'Enter Company Name', Icons.home, _company),
                    SizedBox(height: 10.h),
                    textFieldsCommon(context, 'Enter Company Address',
                        Icons.local_activity_sharp, _address),
                    SizedBox(height: 10.h),
                    textFieldsCommon(
                        context, 'Enter Company Email', Icons.email, _email),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: _number,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      onChanged: (value) {
                        if (value.length >= 10) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      style: ThemeOfApp.subHeadingTextStyle
                          .copyWith(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "Enter Mobile Number",
                        hintStyle: ThemeOfApp.subHeadingTextStyle,
                        prefixIcon: const Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ThemeOfApp.primaryColor)),
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
                            borderSide: const BorderSide(
                                color: ThemeOfApp.primaryColor)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: commonButton(context, "Save", () {
                      isnext.value = true;
                      if (isnext.value == true &&
                          _email.text.isNotEmpty &&
                          _number.text.isNotEmpty &&
                          _address.text.isNotEmpty &&
                          _company.text.isNotEmpty) {
                        db.uploadUserData(
                            context, _company, _address, _email, _number);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Fill all Fields 🥺 ")));
                      }
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
