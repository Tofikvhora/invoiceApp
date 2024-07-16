import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Services/AuthServices.dart';
import 'package:newmahirroadways/Utils/StringNavigations.dart';
import 'package:newmahirroadways/View/auth/SinginPage.dart';
import 'package:newmahirroadways/Widget/CommonButton.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:provider/provider.dart';

class LoginPage extends HookWidget {
  static const String route = 'LoginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _email = useTextEditingController();
    final _passWord = useTextEditingController();
    final AuthServices authServices = AuthServices();
    final isloading = useState<bool>(false);
    final notifier = Provider.of<ImagePickerProvider>(context);
    return Center(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SafeArea(
                    child: Center(
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: ThemeOfApp.headingTextStyle
                            .copyWith(fontSize: 25.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  textFieldsCommon(context, 'Enter Email', Icons.email, _email),
                  SizedBox(height: 10.h),
                  textFieldsCommon(
                      context, 'Enter Password', Icons.password, _passWord),
                  SizedBox(height: 10.h),
                  Text("Forgot password ? ",
                      textAlign: TextAlign.end,
                      style: ThemeOfApp.subHeadingTextStyle
                          .copyWith(color: Colors.blue)),
                  Row(
                    children: [
                      Expanded(
                        child: isloading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: ThemeOfApp.primaryColor))
                            : commonButton(context, 'Login', () {
                                isloading.value = true;
                                Future.delayed(const Duration(seconds: 1), () {
                                  authServices
                                      .loginFunction(_email, _passWord, context,
                                          isloading.value)
                                      .then((value) async {
                                    isloading.value = false;
                                  }).onError((error, stackTrace) {
                                    isloading.value = false;
                                  });
                                });
                              }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140.w,
                          child: const Divider(
                            color: ThemeOfApp.secondaryColor,
                          ),
                        ),
                        Text(" OR ", style: ThemeOfApp.subHeadingTextStyle),
                        SizedBox(
                          width: 140.w,
                          child: const Divider(
                            color: ThemeOfApp.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      SingInPage.route.pushOnThis(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
                          style: ThemeOfApp.subHeadingTextStyle,
                        ),
                        Text(
                          "SignIn",
                          style: ThemeOfApp.subHeadingTextStyle
                              .copyWith(color: Colors.blue),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget textFieldsCommon(BuildContext context, String hint, IconData icons,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    style: ThemeOfApp.subHeadingTextStyle.copyWith(fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: ThemeOfApp.subHeadingTextStyle,
      prefixIcon: Icon(icons),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: ThemeOfApp.primaryColor, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: ThemeOfApp.primaryColor, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ThemeOfApp.primaryColor)),
    ),
  );
}
