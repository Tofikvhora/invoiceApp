import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Services/AuthServices.dart';
import 'package:newmahirroadways/View/auth/LoginPage.dart';

import '../../Constant/Colors.dart';
import '../../Widget/CommonButton.dart';

class SingInPage extends HookWidget {
  static const String route = "SingInPage";
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices authServices = AuthServices();
    final _email = useTextEditingController();
    final _name = useTextEditingController();
    final _passWord = useTextEditingController();
    final isloading = useState<bool>(false);
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
                        "SingIn",
                        textAlign: TextAlign.center,
                        style: ThemeOfApp.headingTextStyle
                            .copyWith(fontSize: 25.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  textFieldsCommon(context, 'Enter Name', Icons.person, _name),
                  SizedBox(height: 10.h),
                  textFieldsCommon(context, 'Enter Email', Icons.email, _email),
                  SizedBox(height: 10.h),
                  textFieldsCommon(
                      context, 'Enter Password', Icons.password, _passWord),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: isloading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: ThemeOfApp.primaryColor))
                            : commonButton(context, 'SingIn', () {
                                isloading.value = true;
                                Future.delayed(const Duration(seconds: 1), () {
                                  authServices
                                      .signIn(_email, _name, _passWord, context,
                                          isloading.value)
                                      .then((value) => isloading.value = false)
                                      .onError((error, stackTrace) =>
                                          isloading.value = false);
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
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
                          style: ThemeOfApp.subHeadingTextStyle,
                        ),
                        Text(
                          "Login",
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
