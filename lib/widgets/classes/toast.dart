import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'app_traits.dart';
import 'category_item.dart';

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(239, 247, 253, 1),
      duration: const Duration(seconds: 2),
    ),
  );
}

Future<int> showIcons(BuildContext context, Color mainColor, int defaultIndex) async {
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
                    children:
                    List.generate(categoryItems.length, (index) {
                      final data = categoryItems[index].data;
                      return GridTile(
                          child: IconButton(
                            icon: Icon(
                              data,
                              size: 30.0,
                              color: mainColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(index);
                            },
                          ));
                    })),
              ),
            )
        );
      }).then((value) {
        if (value == null) {
          return defaultIndex;
        }
        return value;
      });
}