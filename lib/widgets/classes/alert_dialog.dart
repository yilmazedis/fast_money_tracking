import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../localization/methods.dart';

Future<void> iosDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Text(
                getTranslated(context, 'Please Confirm'),
                style: const TextStyle(fontSize: 21),
              ),
            ),
            content: Text(getTranslated(context, content),
                style: const TextStyle(fontSize: 15.5)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                isDefaultAction: false,
                isDestructiveAction: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                  child: Text(getTranslated(context, 'Cancel') ?? 'Cancel',
                      style: const TextStyle(
                          fontSize: 19.5, fontWeight: FontWeight.w600)),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  onAction();
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                  child: Text(getTranslated(context, action) ?? action,
                      style: const TextStyle(
                          fontSize: 19.5, fontWeight: FontWeight.w600)),
                ),
              )
            ],
          );
        });

Future<void> androidDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, 'Please Confirm')),
            content: Text(getTranslated(context, content)),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(getTranslated(context, 'Cancel'))),
              TextButton(
                  onPressed: () {
                    Get.back();
                    onAction();
                  },
                  child: Text(getTranslated(context, action)))
            ],
          );
        });
