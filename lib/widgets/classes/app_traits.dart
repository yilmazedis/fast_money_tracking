import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

RoundedRectangleBorder appShapeBorder({double radius = 20}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        radius,
      ),
    ),
  );
}

textFieldDecoration(String labelText, String hintText, IconData icon) {
  return InputDecoration(
    focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
        BorderRadius.all(Radius.circular(10))),
    enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
        BorderRadius.all(Radius.circular(10))),
    prefixIcon: Icon(
      icon,
      color: AppColor.color30,
    ),
    filled: true,
    fillColor: AppColor.color60,
    labelText: labelText,
    hintText: hintText,
    hintStyle: TextStyle(color: AppColor.color30),
    labelStyle: TextStyle(color: AppColor.color30),
    counterStyle: TextStyle(
      color: AppColor.color60, // Set the desired text color for the character count
    ),
    // suffixIcon: IconButton(
    //     onPressed: () {},
    //     icon: Icon(Icons.close,
    //         color: Colors.purple))
  );
}