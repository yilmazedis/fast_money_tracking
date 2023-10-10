import 'package:flutter/cupertino.dart';

RoundedRectangleBorder appShapeBorder({double radius = 20}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        radius,
      ),
    ),
  );
}