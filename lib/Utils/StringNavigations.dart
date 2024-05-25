import 'package:flutter/material.dart';

extension NavigationOnString on String {
  pushAndReplace(BuildContext context) {
    Navigator.pushReplacementNamed(context, this);
  }

  pushOnThis(BuildContext context) {
    Navigator.pushNamed(context, this);
  }
}
