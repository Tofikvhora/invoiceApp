import 'package:flutter/material.dart';
import 'package:newmahirroadways/Constant/Colors.dart';

Widget textFieldsCommon(BuildContext context, String hint, IconData icons,
    TextEditingController controller, VoidCallback? onTap) {
  return InkWell(
    onTap: onTap,
    child: TextField(
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      style:
          ThemeOfApp.subHeadingTextStyle.copyWith(fontWeight: FontWeight.bold),
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
    ),
  );
}
