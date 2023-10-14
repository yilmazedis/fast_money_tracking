import 'package:fast_money_tracking/localization/methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'app_traits.dart';

enum SnackbarType { error, warning, success }

void showSnackbar(String title, String message, SnackbarType type) {
  IconData iconData;
  Color iconColor;

  switch (type) {
    case SnackbarType.error:
      iconData = Icons.error;
      iconColor = AppColor.red;
      break;
    case SnackbarType.warning:
      iconData = Icons.warning;
      iconColor = AppColor.orange;
      break;
    case SnackbarType.success:
      iconData = Icons.check;
      iconColor = AppColor.blue1;
      break;
  }

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColor.white2,
    icon: Icon(
      iconData,
      color: iconColor,
    ),
  );
}

Future<int> showIcons(
    BuildContext context, Color mainColor, int defaultIndex) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            scrollable: true,
            shape: appShapeBorder(),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Text(
              "Choose A Category",
              style: TextStyle(fontSize: 24.0),
            ),
            content: SizedBox(
              // Specify some width
              height: 300.0, // Change as per your requirement
              width: 300.0,
              child: Scrollbar(
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: List.generate(categoryItems.length, (index) {
                      final data = categoryItems[index].data;
                      final text =
                          getTranslated(context, categoryItems[index].text);
                      return GridTile(
                          child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              data,
                              size: 30.0,
                              color: mainColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(index);
                            },
                          ),
                          Text(
                            text,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          )
                        ],
                      ));
                    })),
              ),
            ));
      }).then((value) {
    if (value == null) {
      return defaultIndex;
    }
    return value;
  });
}
