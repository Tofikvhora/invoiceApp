import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Constant/Colors.dart';
import 'package:newmahirroadways/Utils/SaveList.dart';
import 'package:newmahirroadways/Widget/CommonAppBar.dart';

class SavedMainFile extends HookWidget {
  static const String route = "SavedMainFile";
  const SavedMainFile({super.key});

  @override
  Widget build(BuildContext context) {
    final List dummy = ["All Saved Invoices", "All Saved Truck Details"];
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        children: [
          SafeArea(child: commonAppBar(context)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 15.h),
              itemCount: SaveList.items(context).length,
              itemBuilder: (context, index) {
                final item = SaveList.items(context)[index];
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
                              item.img,
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
                                fontSize: 10.sp,
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
      ),
    );
  }
}
